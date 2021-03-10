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
    # not working for now
    # client.reply_message(event['replyToken'], { type: 'text', text: "Pantry is hereeeeeee!" }) if events.first == Line::Bot::Event::Join
    user = get_ids(events)
    
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
          LinebotShareJob.perform_now(user.shopping_lists.last, client, user)
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
  
  def get_ids(events)
    # assumes that user will log in with their LINE account (that lets us know their LINE user ID)
    # when they sign up with LINE, Pantry LINE messaging bot will be automatically added as a friend
    # when an individual user commands Pantry bot, we use the LINE user ID from their message to find our user's web account
    # when they (presumably as a household head) add and talk to Pantry bot in a family chat group , we will update LINE group ID for their household
    # or create their household
    # every time there is a call back request from the group, we find the household with group ID, find the household head
    # (for now assuming only household head has account on Pantry app) and its head user, and make changes to the pantry of that head user

    events.each do |event|
      id = event['source']['userId']
      unless User.exists?(line_id: id)
        client.reply_message(event['replyToken'], { type: 'text', text: 'Please sign up with LINE on www.digitalpantry.me'})
      end
      user = User.find_by(line_id: id)

      case event.type
      when Line::Bot::Event::MessageType::Text
        if event['source']['groupId']
          group_line_id = event['source']['groupId']
          unless Household.exists?(line_id: id)
            household = Household.create(line_id: group_line_id)
            user.update(household_id: household.id)  # update household LINE ID everytime this user added Pantry bot to a new group
          end
        end
      end

      return user
      'OK'
    end
  end

  def default_message
    "Hey! I'm your assistant from Pantry app 🥑 \n"\
    "I am good at: 🦾\n"\
    "🧀 Add a new item to your shopping list.\n👉 'Pantry, add <amount> of <item name>'\n or 'Pantry, add <item name>'\n"\
    "📥 Load all your bought items to your digital pantry in the Pantry app.\n👉 Simply say: 'Pantry, shopping done!'\n"\
    "📝 Show your latest shopping list.\n👉 Just say: 'Pantry, list!'\n"\
    "Give it a go!😀"
  end
end
