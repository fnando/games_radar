require "test_helper"

class GamesRadarTest < Test::Unit::TestCase
  def test_setup_api_key
    GamesRadar.setup do |c|
      c.api_key = "abc"
    end

    assert_equal "abc", GamesRadar::Config.api_key
  end
end