class LinebotLoadToPantryJob < ApplicationJob

  def perform(user)
    shopping_list = user.shopping_lists.last
    return 'You have no shopping lists!' if shopping_list.nil?
    
    shopping_amounts = shopping_list.shopping_amounts
    load_to_pantry(shopping_amounts, user)

    shopping_list.destroy
    'Check your 🥑 Pantry app (www.digitalpantry.me) to see new items added!'
  end

  private

  def load_to_pantry(shopping_amounts, user)
    shopping_amounts.each do |shopping_amount|
      pantry_item = ItemAmount.new(item_id: shopping_amount.item.id)
      pantry_item.user = user
      pantry_item.description = shopping_amount.description
      pantry_item.save
    end
  end
end
