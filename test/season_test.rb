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

  def test_returns_regular_season_win_percentage
    @season.stubs(regular_season_win_percentage: 0.66)
    assert_equal 0.66, @season.regular_season_win_percentage
  end

  def test_returns_post_season_win_percentage
    @season.stubs(post_season_win_percentage: 0)
    assert_equal 0, @season.post_season_win_percentage
  end

  def test_returns_shot_accuracy
    @season.stubs(shot_accuracy: 0.5)
    assert_equal 0.5, @season.shot_accuracy
  end

  def test_returns_number_of_hits
    @season.stubs(number_of_hits: 25)
    assert_equal 25, @season.number_of_hits
  end

  def test_returns_power_play_goal_percentage
    @season.stubs(power_play_goal_percentage: 0.1)
    assert_equal 0.1, @season.power_play_goal_percentage
  end

  def test_returns_regular_goals_total
    @season.stubs(regular_season_goals: 13)
    assert_equal 13, @season.regular_season_goals
  end

  def test_returns_post_goals_total
    @season.stubs(post_season_goals: 7)
    assert_equal 7, @season.post_season_goals
  end

end
