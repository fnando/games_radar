# encoding: utf-8

require "test_helper"

class GamesRadar::GameTest < Test::Unit::TestCase
  def setup
    GamesRadar::Config.api_key = "SxKuVse22qqUcZXq"
  end

  def test_find_game_by_id
    register_uri "/game/20060713144458560042?api_key=SxKuVse22qqUcZXq", "game.xml"
    game = GamesRadar::Game.find("20060713144458560042")

    assert_kind_of GamesRadar::Game, game
    assert_kind_of GamesRadar::Game, game
    assert_kind_of GamesRadar::Genre, game.genre
    assert_equal "20060713144458560042", game.id
    assert_equal "God of War III", game.name[:us]
    assert_equal "God of War 3", game.name[:uk]
    assert_equal "God of War III", game.title
    assert_match /mythology’s darkest creatures/, game.description
  end

  def test_raise_error_when_game_is_not_found
    register_uri "/game/0000?api_key=SxKuVse22qqUcZXq", "game_not_found.xml"
    assert_raise(GamesRadar::GameNotFoundError) { GamesRadar::Game.find("0000") }
  end

  def test_return_list_game_with_defaults
    register_uri "/games?api_key=SxKuVse22qqUcZXq&page_size=50&page_num=1&sort=newest", "games.xml"
    result = GamesRadar::Game.all

    assert_equal 50, result.items.size
    assert_equal 12242, result.count
    assert_equal 245, result.pages
    assert_equal 50, result.page_size
  end

  def test_no_game_list
    register_uri "/games?api_key=SxKuVse22qqUcZXq&page_size=50&page_num=1&sort=newest", "no_games.xml"
    result = GamesRadar::Game.all

    assert_equal 0, result.items.size
    assert_equal 0, result.pages
    assert_equal 0, result.count
  end

  def test_game_list_with_custom_options
    register_uri "/games?api_key=SxKuVse22qqUcZXq&page_size=5&page_num=10&sort=updated&genre=sport+games&game_name=a", "games.xml"
    result = GamesRadar::Game.all(:page => 10, :size => 5, :filter => :a, :genre => :sports, :sort => :updated)

    assert_equal 50, result.items.size
  end

  def test_game_list_sorted_by_asc
    register_uri "/games?api_key=SxKuVse22qqUcZXq&page_size=50&page_num=1&sort=a-z", "games.xml"
    result = GamesRadar::Game.all(:sort => :asc)

    assert_equal 50, result.items.size
  end

  def test_game_list_sorted_by_desc
    register_uri "/games?api_key=SxKuVse22qqUcZXq&page_size=50&page_num=1&sort=z-a", "games.xml"
    result = GamesRadar::Game.all(:sort => :desc)

    assert_equal 50, result.items.size
  end

  def test_game_list_filtered_by_numbers
    register_uri "/games?api_key=SxKuVse22qqUcZXq&page_size=50&page_num=1&game_name=0-9&sort=newest", "games.xml"
    result = GamesRadar::Game.all(:filter => "0-9")

    assert_equal 50, result.items.size
  end

  def test_screenshots
    register_uri "/game/20060713144458560042?api_key=SxKuVse22qqUcZXq", "game.xml"
    register_uri "/game/screenshots/20060713144458560042?page_num=1&page_size=50&api_key=SxKuVse22qqUcZXq&region=us", "screenshots.xml"

    game = GamesRadar::Game.find("20060713144458560042")

    assert_kind_of GamesRadar::Result, game.screenshots
    assert_equal 50, game.screenshots.items.size
    assert_kind_of GamesRadar::Screenshot, game.screenshots.items.first
  end
end
