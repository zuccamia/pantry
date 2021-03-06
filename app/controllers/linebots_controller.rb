class LinebotsController < ApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_action :authenticate_user!, only: [ :call_back ]
  
  def client
    @client ||= Line::Bot::Client.new { |config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    }
  end

  def share
    shopping_list = ShoppingList.find(params[:id])
    LinebotShareJob.perform_now(shopping_list, client, current_user)

    redirect_to recipes_path, notice: "Successfully shared your shopping list to your LINE group!"
  end

  def call_back
    body = request.body.read
    events = client.parse_events_from(body)
    user = find_user(events)
    
    events.each do |event|
      
      case event.type
        # when receive a text message
      when Line::Bot::Event::MessageType::Text
        return '' unless event.message['text'].downcase.include?('pantry') # Only answer to messages with 'pantry'

        if event.message['text'].downcase.include?('add')
          response = LinebotAddToListJob.perform_now(event.message['text'], user, default_message)
        elsif event.message['text'].downcase.include?('shopping done')
          response = LinebotLoadToPantryJob.perform_now(user)
        elsif event.message['text'].downcase.include?('list')
          LinebotShareJob.perform_now(items, client, user)
        else
          response = default_message
        end
        message_hash = {
          type: 'text',
          text: response
        }
        client.reply_message(event['replyToken'], message_hash)

        'OK'
      end
    end
  end

  private
  
  def find_user(events)
    id = events.first['source']['userId']
    user = User.find_by(line_id: id)
  end

  def default_message
    "Sorry I am not sure how to do that...🥶 \n"\
    "However, I am good at: 🦾\n"\
    "🧀 Add a new item to your shopping list.\n👉 'Pantry, add <amount> of <item name>'\n or 'Pantry, add <item_name>'\n"\
    "📥 Load all your bought items to your digital pantry in the Pantry app.\n👉 Simply say: 'Pantry, shopping done!'\n"\
    "Give it a go!😀"
  end
end
