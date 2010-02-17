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

    # Retrieve the game list.
    #
    # == Options
    #
    # * +:filter+: filter the results by title. You can specify a letter from +a+ to +z+ or +0-9+.
    # * +:genre+: set the game genre. Can be +all+ or any value from GamesRadar::Genre::GENRES.
    # * +:page+: set the current page. If a page is not found, an empty array will be returned.
    # * +:platform+: set the console platform. Can be +all+ or any code returned by GamesRadar::Platform#code
    # * +:sort+: specify how the result will be sorted. The available options are +newest+, +oldest+, +updated+, +asc+ and +desc+.
    def self.all(options = {})
      options = {
        :page => 1,
        :size => GamesRadar::Config.page_size,
        :sort => :newest
      }.merge(options)

      request "/games", options do |xml|
        total_rows = xml.at("total_rows").inner_text.to_i
        items = xml.search("game").collect {|node| new(node) }

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

      new(
        :id => xml.at("id").inner_text,
        :name => {
          :us => xml.at("name > us").inner_text,
          :uk => xml.at("name > uk").inner_text
        },
        :platform => GamesRadar::Platform.new(xml.at("platform > id").inner_text),
        :genre => GamesRadar::Genre.new(xml.at("genre > id").inner_text),
        :description => Nokogiri(xml.at("description").inner_text).inner_text
      )
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
  end
end
