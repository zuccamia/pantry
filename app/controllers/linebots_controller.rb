class LinebotsController < ApplicationController
  require 'line/bot'

  def call_back
    body = request.body.read

    @client ||= Line::Bot::Client.new { |config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_ACCESS_TOKEN"]
    }

    events = @client.parse_events_from(body)
    events.each do |event|
      case event.type
      # when receive a text message
      when Line::Bot::Event::MessageType::Text
        @user = User.find_by(line_id: event['source']['userId'])
      end
    end
  end
end
