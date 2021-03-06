class LinebotShareJob < ApplicationJob

  def perform(shopping_list)
    list = shopping_list.shopping_amounts.map.with_index { |ingredient, index| "#{index + 1}. #{ingredient.item.item_name}: #{ingredient.description}" }.join("\n")

    @client ||= Line::Bot::Client.new { |config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    }
    
    # Hardcoded for MVP purpose
    groupId = "C842812916876d29a54f177c3bd65d2ba"

    message = {
      type: 'text',
      text: list
    }
    @client.push_message(groupId, message)
  end
end
