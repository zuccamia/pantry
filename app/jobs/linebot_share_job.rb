class LinebotShareJob < ApplicationJob

  def perform(shopping_list, client, user)
    list = shopping_list.shopping_amounts.map.with_index { |ingredient, index| "#{index + 1}. #{ingredient.item.item_name}: #{ingredient.description}" }.join("\n")
    message_text = list.empty? ? "You have no shopping lists!" : "Heyo 👋! Here's your new shopping list for today, #{Date.today.to_formatted_s(:rfc822)}\n#{list}"
    
    destination = user.household.nil? ? user.line_id : user.household.line_id
    message = {
      type: 'text',
      text: message_text
    }
    client.push_message(destination, message)
  end
end
