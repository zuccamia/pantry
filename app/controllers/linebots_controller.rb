class LinebotsController < ApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_action :authenticate_user!, only: [ :call_back ]
  
  def client
    @client ||= Line::Bot::Client.new { |config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    }
  end

  def share
    items = params[:shopping_list]
    LinebotShareJob.perform_now(items, client, current_user)

    redirect_to recipes_path, notice: "Successfully shared your shopping list to your LINE group!"
  end

  def call_back
    LinebotAddToListJob.perform_now(client, current_user)
  end
end
