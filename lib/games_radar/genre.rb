module GamesRadar
  class Genre
    GENRES = {
      "1"  => :action,
      "2"  => :fighting,
      "3"  => :adventure,
      "4"  => :arcade,
      "5"  => :racing,
      "6"  => :shooter,
      "7"  => :flight,
      "8"  => :strategy,
      "9"  => :rpg,
      "10" => :sports,
      "11" => :other,
      "12" => :family,
      "13" => :children,
      "14" => :puzzle,
      "15" => :simulation
    }

    # The genre id
    attr_reader :id

    # The genre name
    attr_reader :name

    # Set up genre attributes based on the specified id.
    # The available genres can be found on the GamesRadar::Genre::GENRES constant.
    def initialize(id)
      @id = id.to_s
      @name = GENRES[@id]

      raise GamesRadar::UnknownGenreError unless name
    end
  end
end