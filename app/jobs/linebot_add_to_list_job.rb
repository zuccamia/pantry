class LinebotAddToListJob < ApplicationJob

  def perform(message, user, default_message)
    
    if user.shopping_lists.empty?
      shopping_list = ShoppingList.create(user_id: user.id)
    else
      shopping_list = user.shopping_lists.last
    end

    if message.downcase.match?(/add.+of.+/)
      item = message.downcase.gsub(/(pantry|add|,)/, '').split('of')
      item_name = item.pop.strip.capitalize
      description = item.shift.strip
      add_to_list(item_name, description, shopping_list)

      "#{description} of #{item_name} added!"
    elsif message.downcase.match?(/^.((?!of).).*add.*$/)
      item_name = message.downcase.gsub(/(pantry|add|,)/, '').strip.capitalize
      add_to_list(item_name, nil, shopping_list)
      
      "#{item_name} added!"
    end
  end

  private

  def add_to_list(item_name, description, shopping_list)
    new_shopping_amount = ShoppingAmount.new(description: description)
    new_shopping_amount.item = find_item(item_name)
    new_shopping_amount.shopping_list = shopping_list
    new_shopping_amount.save
  end
  
  def find_item(item_name)      # check if item already exists in item database, if not create new
    if Item.exists?(item_name: item_name)
      item = Item.where(item_name: item_name).first
    else
      item = Item.new(item_name: item_name)
      item.category = Category.find_by(main_category: 'TBD')
      item.save
    end
    item
  end
end
