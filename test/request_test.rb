require "test_helper"

class GamesRadar::GenreTest < Test::Unit::TestCase
  def setup
    GamesRadar::Config.api_key = "SxKuVse22qqUcZXq"
    @request = Object.extend(GamesRadar::Request)
  end

  def test_replace_rpg_value_for_genre
    options = {:genre => :rpg}
    @request.prepare_params!(options)
    assert_equal "role+playing", options[:genre]
  end

  def test_replace_other_value_for_genre
    options = {:genre => :other}
    @request.prepare_params!(options)
    assert_equal "other+games%2Fcompilations", options[:genre]
  end

  def test_replace_children_value_for_genre
    options = {:genre => :children}
    @request.prepare_params!(options)
    assert_equal "children%27s", options[:genre]
  end

  def test_replace_sports_value_for_genre
    options = {:genre => :sports}
    @request.prepare_params!(options)
    assert_equal "sport+games", options[:genre]
  end
end
