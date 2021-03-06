class LinebotAddToListJob < ApplicationJob

  def perform
    body = request.body.read

    @client ||= Line::Bot::Client.new { |config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    }

    events = @client.parse_events_from(body)
    events.each do |event|
      case event.type
      # when receive a text message
      when Line::Bot::Event::MessageType::Text
        p event.message['text']
        LinebotShareJob.perform_now(ShoppingList.last)
        'OK'
      end
    end

    private

    def add_item_to_shopping_list(message)
      return '' unless message.downcase.include?('pantry') # Only answer to messages with 'pantry'
      default_message = 'I am not sure how to do that. (oops)'\
                        'However, I am good at:'\
                        '(chocolate cake)Add a new item to your shopping list. Just say: "Pantry, add <amount> of <item anem> please." (moon grin)'\
                        '(cellphone)Load all your bought items to your digital pantry in the Pantry app. Simple say: "Pantry, shopping done!" (content)'\
                        'Give it a go! (eighthnote)'

      if message.downcase.include?('add')
        # message.downcase.inclue?('of')
      else
        default_message
      end
    end
  end
end
