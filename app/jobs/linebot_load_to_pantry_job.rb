class LinebotLoadToPantryJob < ApplicationJob

  def perform(user)
    shopping_list = user.shopping_lists.last
    shopping_amounts = shopping_list.shopping_amounts
    load_to_pantry(shopping_amounts)

    shopping_list.destroy
  end

  private

  def load_to_pantry(shopping_amounts)
    shopping_amounts.each do |shopping_amount|
      pantry_item = ItemAmount.new(item_id: shopping_amount.item.id)
      pantry_item.user = user
      pantry_item.description = shopping_amount.description
      pantry_item.save
    end
  end
end
