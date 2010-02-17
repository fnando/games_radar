require "test_helper"

class GamesRadar::ConfigTest < Test::Unit::TestCase
  def test_default_values
    GamesRadar::Config.defaults!

    assert_nil GamesRadar::Config.api_key
    assert_equal 50, GamesRadar::Config.page_size
  end
end