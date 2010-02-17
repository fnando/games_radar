module GamesRadar
  class Config
    class << self
      # Set your API key that is sent in every request.
      # To request your own API key, just go to http://www.gamesradar.com/api-key-request
      attr_accessor :api_key

      # Set how many items the API will return. Defaults to 50.
      attr_accessor :page_size
    end

    # Restore all default attributes accepted by GamesRadar::Config class.
    def self.defaults!
      GamesRadar.setup do |c|
        c.api_key = nil
        c.page_size = 50
      end
    end
  end
end
