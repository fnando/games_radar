require "test_helper"

class GamesRadar::ScreenshotTest < Test::Unit::TestCase
  def setup
    register_uri "/game/20060713144458560042?api_key=SxKuVse22qqUcZXq", "game.xml"
    register_uri "/game/screenshots/20060713144458560042?page_num=1&page_size=50&api_key=SxKuVse22qqUcZXq&region=us", "screenshots.xml"

    @game = GamesRadar::Game.find("20060713144458560042")
    @screenshot = @game.screenshots.items.first
  end

  def test_set_large_image_url
    assert_equal "http://static.gamesradar.com/images/mb/GamesRadar/us/Games/G/God%20Of%20War%203/Bulk%20Viewers/PS3/2010-01-18/Gaia01--screenshot_viewer_medium.jpg", @screenshot.image
  end

  def test_set_thumbnail_url
    assert_equal "http://static.gamesradar.com/images/mb/GamesRadar/us/Games/G/God%20Of%20War%203/Bulk%20Viewers/PS3/2010-01-18/Gaia01--screenshot_small.jpg", @screenshot.thumbnail
  end

  def test_set_url
    assert_equal "http://www.gamesradar.com/ps3/god-of-war-iii/screenshots/g-20060713144458560042/pic-C50D60BB-4B4D-48B3-9D6D-A4969D5F5236", @screenshot.url
  end

  def test_set_published_at
    assert_equal Time.parse("2010-01-18T00:00:00.00+0000"), @screenshot.published_at
  end
end
