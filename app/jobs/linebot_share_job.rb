require 'line/bot'

class LinebotShareJob < ApplicationJob

  def perform(shopping_list)
    user = @user
    message = shopping_list.map { |ingredient| ingredient.item.item_name }.join('\n')
    @client.broadcast(message)
  end
end
