class ApplicationService
  require 'open-uri'
  require 'json'
  require 'dotenv'
  Dotenv.load
  require 'active_record'
  
  def self.call(*args, &block)
    new(*args, &block).call
  end

  private

  def api_key
    ENV['SPOONACULAR']
  end
end
