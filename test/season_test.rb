require 'csv'
require 'mocha/minitest'
require './lib/season'

class SeasonTest < MiniTest::Test

  def setup
    @game_1_find = mock("Game 1 Find")
    @game_1_find.stubs(won: "TRUE", shots: 8, goals: 4, hits: 6, powerplaygoals: 1)
    @game_1_team_stats = mock("Game 1 Stats")
    @game_1_team_stats.stubs(find: @game_1_find)
    @game_1 = mock("Game 1")
    @game_1.stubs(type: "R", team_stats: @game_1_team_stats)
    @game_2_find = mock("Game 2 Find")
    @game_2_find.stubs(won: "TRUE", shots: 10, goals: 5, hits: 6, powerplaygoals: 0)
    @game_2_team_stats = mock("Game 2 Stats")
    @game_2_team_stats.stubs(find: @game_2_find)
    @game_2 = mock("Game 2")
    @game_2.stubs(type: "R", team_stats: @game_2_team_stats)
    @game_3_find = mock("Game 3 Find")
    @game_3_find.stubs(won: "FALSE", shots: 6, goals: 3, hits: 6, powerplaygoals: 0)
    @game_3_team_stats = mock("Game 3 Stats")
    @game_3_team_stats.stubs(find: @game_3_find)
    @game_3 = mock("Game 3")
    @game_3.stubs(type: "R", team_stats: @game_3_team_stats)
    @game_4_find = mock("Game 4 Find")
    @game_4_find.stubs(won: "FALSE", shots: 16, goals: 8, hits: 7, powerplaygoals: 0)
    @game_4_team_stats = mock("Game 4 Stats")
    @game_4_team_stats.stubs(find: @game_4_find)
    @game_4 = mock("Game 4")
    @game_4.stubs(type: "P", team_stats: @game_4_team_stats)
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
    assert_equal 0.67, @season.regular_season_win_percentage
  end

  def test_returns_post_season_win_percentage
    assert_equal 0, @season.post_season_win_percentage
  end

  def test_returns_shot_accuracy
    assert_equal 0.5, @season.shot_accuracy
  end

  def test_returns_number_of_hits
    assert_equal 25, @season.number_of_hits
  end

  def test_returns_power_play_goal_percentage
    assert_equal 0.05, @season.power_play_goal_percentage
  end

  def test_returns_regular_season_goals_total
    assert_equal 12, @season.regular_season_goals
  end

  def test_returns_post_season_goals_total
    assert_equal 8, @season.post_season_goals
  end
#
#   def test_returns_regular_season_goals_against
#     @season.stubs(regular_goals_against: 10)
#     assert_equal 10, @season.regular_goals_against
#   end
#
#   def test_returns_post_season_goals_against
#     @season.stubs(post_goals_against: 10)
#     assert_equal 10, @season.post_goals_against
#   end
#
#   def test_returns_regular_season_average_goals
#     @season.stubs(regular_season_average_goals: 4)
#     assert_equal 4, @season.regular_season_average_goals
#   end
#
#   def test_returns_post_season_average_goals
#     @season.stubs(post_season_average_goals: 8)
#     assert_equal 8, @season.post_season_average_goals
#   end
#
#   def test_returns_regular_season_average_goals_against
#     @season.stubs(regular_season_average_goals_against: 3.33)
#     assert_equal 3.33, @season.regular_season_average_goals_against
#   end
#
#   def test_returns_post_season_average_goals_against
#     @season.stubs(post_season_average_goals_against: 10)
#     assert_equal 10, @season.post_season_average_goals_against
#   end
#
end
