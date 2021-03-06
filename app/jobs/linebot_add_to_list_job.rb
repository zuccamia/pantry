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
        p event
        message = { type: 'text', text: 'Here is your list:' }
        @client.push_message(event['replyToken'], message)
        'OK'
      end
    end

    private

    def add_item_to
      
    end
  end
end
