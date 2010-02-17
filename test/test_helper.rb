require "rubygems"
require "test/unit"
require "fakeweb"

$LOAD_PATH.unshift File.dirname(__FILE__) + "/../lib"

require "games_radar"

FakeWeb.allow_net_connect = false

class Test::Unit::TestCase
  def resource(path)
    File.read File.dirname(__FILE__) + "/resources/#{path}"
  end

  def register_uri(path, options = {})
    url = File.join(GamesRadar::Request::BASE_URL, path)
    options = {:body => resource(options)} if options.kind_of?(String)
    FakeWeb.register_uri(:get, url, options)
  end
end