require "cgi"
require "nokogiri"
require "open-uri"
require "uri"

require "games_radar/request"
require "games_radar/config"
require "games_radar/errors"
require "games_radar/game"
require "games_radar/genre"
require "games_radar/platform"
require "games_radar/result"
require "games_radar/screenshot"
require "games_radar/version"

module GamesRadar
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
