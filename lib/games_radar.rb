require "cgi"
require "nokogiri"
require "open-uri"
require "uri"

module GamesRadar
  require "games_radar/errors"

  autoload :Request     , "games_radar/request"
  autoload :Config      , "games_radar/config"
  autoload :Game        , "games_radar/game"
  autoload :Genre       , "games_radar/genre"
  autoload :Platform    , "games_radar/platform"
  autoload :Result      , "games_radar/result"
  autoload :Screenshot  , "games_radar/screenshot"
  autoload :Version     , "games_radar/version"

  # Use this shortcut for GamesRadar::Config. Refer to the GamesRadar::Config
  # for all available options.
  #
  # Instead of setting values like
  #
  #   GamesRadar::Config.api_key = "SxKuVse22qqUcZXq"
  #
  # You can write it as
  #
  #   GamesRadar.setup do |c|
  #     c.api_key = "SxKuVse22qqUcZXq"
  #   end
  def self.setup(&block)
    yield GamesRadar::Config
  end
end

# Set up default values
GamesRadar::Config.defaults!
