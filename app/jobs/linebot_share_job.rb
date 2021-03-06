class LinebotShareJob < ApplicationJob

  def perform(shopping_list, client, user)
    list = shopping_list.shopping_amounts.map.with_index { |ingredient, index| "#{index + 1}. #{ingredient.item.item_name}: #{ingredient.description}" }.join("\n")

    # Hardcoded for MVP purpose
    groupId = "C842812916876d29a54f177c3bd65d2ba"

    message = {
      type: 'text',
      text: "Heyo 👋! Here's your new shopping list for today, #{Date.today.to_formatted_s(:rfc822)}\n"\
            "#{list}"
    }
    client.push_message(groupId, message)
  end
end
