require "test_helper"

class GamesRadar::PlatformTest < Test::Unit::TestCase
  def test_raise_invalid_platform_id
    assert_raise(GamesRadar::UnknownPlatformError) { GamesRadar::Platform.new("invalid") }
  end

  def test_set_attributes_for_valid_id
    platform = GamesRadar::Platform.new(5)

    assert_equal "PlayStation 3", platform.name
    assert_equal "5", platform.id
    assert_equal :ps3, platform.code
  end
end