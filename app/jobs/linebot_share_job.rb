class LinebotShareJob < ApplicationJob

  def perform(items, client, user)
    shopping_list = create_shopping_list(items, user)
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

  private

  def create_shopping_list(items, user)
    shopping_list = ShoppingList.new
    shopping_list.user = user
    shopping_list.save

    items.each do |item_id|
      recipe_amount = RecipeAmount.find(item_id.to_i)
      shopping_amount = ShoppingAmount.new(description: recipe_amount.description, item_id: recipe_amount.item.id)
      shopping_amount.shopping_list = shopping_list
      shopping_amount.save
    end

    shopping_list
  end
end
