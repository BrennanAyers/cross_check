require 'csv'
require 'mocha/minitest'
require './lib/season'

class SeasonTest < MiniTest::Test

  def setup
    @game_1 = mock
    @game_1.stubs(type: "R")
    @game_2 = mock
    @game_2.stubs(type: "R")
    @game_3 = mock
    @game_3.stubs(type: "R")
    @game_4 = mock
    @game_4.stubs(type: "P")
    @season = Season.new([@game_1, @game_2, @game_3, @game_4], 1)
  end

  def test_has_argument_attributes
    assert_equal [@game_1, @game_2, @game_3, @game_4], @season.games
    assert_equal 1, @season.team_id
  end

  def test_has_regular_and_post_season_games
    assert_equal [@game_1, @game_2, @game_3], @season.regular_season_games
    assert_equal [@game_4], @season.post_season_games
  end

  def test_returns_win_percentage
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

  def test_returns_regular_season_goals_total
    @season.stubs(regular_season_goals: 12)
    assert_equal 12, @season.regular_season_goals
  end

  def test_returns_post_season_goals_total
    @season.stubs(post_season_goals: 8)
    assert_equal 8, @season.post_season_goals
  end

  def test_returns_regular_season_goals_against
    @season.stubs(regular_goals_against: 10)
    assert_equal 10, @season.regular_goals_against
  end

  def test_returns_post_season_goals_against
    @season.stubs(post_goals_against: 10)
    assert_equal 10, @season.post_goals_against
  end

  def test_returns_regular_season_average_goals
    @season.stubs(regular_season_average_goals: 4)
    assert_equal 4, @season.regular_season_average_goals
  end

  def test_returns_post_season_average_goals
    @season.stubs(post_season_average_goals: 8)
    assert_equal 8, @season.post_season_average_goals
  end

  def test_returns_regular_season_average_goals_against
    @season.stubs(regular_season_average_goals_against: 3.33)
    assert_equal 3.33, @season.regular_season_average_goals_against
  end

  def test_returns_post_season_average_goals_against
    @season.stubs(post_season_average_goals_against: 10)
    assert_equal 10, @season.post_season_average_goals_against
  end

end
