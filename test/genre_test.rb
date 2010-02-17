require "test_helper"

class GamesRadar::GenreTest < Test::Unit::TestCase
  def test_raise_invalid_genre_id
    assert_raise(GamesRadar::UnknownGenreError) { GamesRadar::Genre.new("invalid") }
  end

  def test_set_attributes_for_valid_id
    genre = GamesRadar::Genre.new(1)

    assert_equal :action, genre.name
    assert_equal "1", genre.id
  end
end
