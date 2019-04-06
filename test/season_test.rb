require 'csv'
require 'mocha/minitest'

class SeasonTest < MiniTest::Test

  def setup
    @season = mock
    @game_1 = mock
    @game_2 = mock
    @game_3 = mock
    @game_4 = mock
  end

  def test_has_regular_and_post_season_games
    @season.stubs(regular_season_games: [@game_1, @game_2, @game_3], post_season_games: [@game_4])
    assert_equal [@game_1, @game_2, @game_3], @season.regular_season_games
    assert_equal [@game_4], @season.post_season_games
  end

  def test_returns_win_percentage
    @season.stubs(win_percentage: 0.5)
    assert_equal 0.5, @season.win_percentage
  end

end
