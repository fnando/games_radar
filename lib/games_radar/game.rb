module GamesRadar
  class Game
    include GamesRadar::Request
    extend GamesRadar::Request

    # The game id
    attr_reader :id

    # The game name. The hash contains both US and UK names.
    attr_reader :name

    # The console platform. Is a GamesRadar::Platform instance.
    attr_reader :platform

    # The game genre. Is a GamesRadar::Genre instance.
    attr_reader :genre

    # The game description
    attr_reader :description

    # Retrieve the game list. Return a GamesRadar::Result instance.
    #
    # == Options
    #
    # * +:filter+: filter the results by title. You can specify a letter from +a+ to +z+ or +0-9+.
    # * +:genre+: set the game genre. Can be +all+ or any value from GamesRadar::Genre::GENRES.
    # * +:page+: set the current page.
    # * +:size+: set the page size. Can be +5+ or multiples of +10+ up to +50+.
    # * +:platform+: set the console platform. Can be +all+ or any code returned by GamesRadar::Platform#code
    # * +:sort+: specify how the result will be sorted. The available options are +newest+, +oldest+, +updated+, +asc+ and +desc+.
    #
    # == Examples
    #
    #   result = GamesRadar::Game.all
    #   result = GamesRadar::Game.all(:filter => 'a')
    #   result = GamesRadar::Game.all(:filter => '0-9')
    #   result = GamesRadar::Game.all(:genre => :sports)
    #   result = GamesRadar::Game.all(:page => 1)
    #   result = GamesRadar::Game.all(:platform => :ps3)
    #   result = GamesRadar::Game.all(:sort => :asc)
    #
    #   result.each do |game|
    #     puts game.title
    #   end
    def self.all(options = {})
      options = {
        :page => 1,
        :size => GamesRadar::Config.page_size,
        :sort => :newest
      }.merge(options)

      request "/games", options do |xml|
        total_rows = xml.at("total_rows").text.to_i
        items = xml.search("game").collect {|node| initialize_with_node node }

        GamesRadar::Result.new(
          :items     => items,
          :page_size => options[:size],
          :count     => total_rows
        )
      end
    end

    # Initialize a GamesRadar::Game object with a game node.
    def self.initialize_with_node(xml) # :nodoc:
      raise GamesRadar::GameNotFoundError unless xml.at("id")

      # First set up mandatory attributes
      options = {
        :id => xml.at("id").text,
        :name => {
          :us => xml.at("name > us").text,
          :uk => xml.at("name > uk").text
        },
        :platform => GamesRadar::Platform.new(xml.at("platform > id").text)
      }

      # Then set up optional attributes
      options[:genre] = GamesRadar::Genre.new(xml.at("genre > id").text) if xml.at("genre > id")
      options[:description] = Nokogiri(xml.at("description").text).text if xml.at("description")

      new(options)
    end

    # Return a game with the specified id.
    #
    #   game = GamesRadar::Game.find("2005120717014294613647")
    #
    def self.find(id)
      request "/game/:id", :id => id do |xml|
        Game.initialize_with_node(xml.search("game"))
      end
    end

    # Initialize a new game object and set the hash to its
    # attributes.
    #
    #   game = GamesRadar::Game.new(
    #     :id => "2005120717014294613647",
    #     :name => "Grand Theft Auto: San Andreas"
    #   )
    def initialize(attrs = {})
      attrs.each do |name, value|
        instance_variable_set("@#{name}", value)
      end
    end

    # Return the US game as main title.
    def title
      name[:us]
    end

    # Retrieve the screenshot list. Return a GamesRadar::Result instance.
    #
    # == Options
    #
    # * +:region+: filter screenshots by region. Can be +us+ or +uk+.
    # * +:page+: set the current page.
    # * +:size+: set the page size. Can be +5+ or multiples of +10+ up to +50+.
    def screenshots(options = {})
      options = {
        :region => :us,
        :page => 1,
        :size => GamesRadar::Config.page_size
      }.merge(options)

      request "/game/screenshots/:id", options.merge(:id => id) do |xml|
        total_rows = xml.at("total_rows").text.to_i
        items = xml.search("screenshot").collect {|node| GamesRadar::Screenshot.initialize_with_node node }

        GamesRadar::Result.new(
          :items     => items,
          :page_size => options[:size],
          :count     => total_rows
        )
      end
    end
  end
end
