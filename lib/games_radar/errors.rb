module GamesRadar
  # The GamesRadar::InvalidApiKeyError is raised when the request returns the code
  # 10001.
  class InvalidApiKeyError < StandardError
    def message # :nodoc:
      "Your API key is invalid. Visit http://www.gamesradar.com/api-key-request to register one."
    end
  end

  # The GamesRadar::UnknownPlatformError is raised when an invalid platform id is
  # informed while instantiating a new GamesRadar::Platform object.
  class UnknownPlatformError < StandardError; end

  # The GamesRadar::UnknownGenreError is raised when an invalid genre id is
  # informed while instantiating a new GamesRadar::Genre object.
  class UnknownGenreError < StandardError; end

  # The GamesRadar::GameNotFoundError is raised when a game is not found by
  # the provided id.
  class GameNotFoundError < StandardError; end
end
