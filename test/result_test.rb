require "test_helper"

class GamesRadar::ResultTest < Test::Unit::TestCase
  class Sample; end

  def setup
    @result = GamesRadar::Result.new(
      :count => 50,
      :page_size => 50,
      :items => Array.new(50) { Sample.new }
    )
  end

  def test_each
    @result.each do |sample|
      assert_kind_of Sample, sample
    end
  end

  def test_each_with_index
    @result.each_with_index do |sample, i|
      assert_kind_of Sample, sample
      assert_kind_of Integer, i
    end
  end

  def test_set_pages_count
    result = GamesRadar::Result.new(:count => 10, :page_size => 1, :items => [1])
    assert_equal 10, result.pages
  end

  def test_no_pages
    result = GamesRadar::Result.new(:count => 10, :page_size => 1, :items => [])
    assert_equal 0, result.pages
  end
end
