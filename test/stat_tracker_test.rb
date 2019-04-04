require "./test/test_helper"
require "./lib/stat_tracker"
require "csv"

class StatTrackerTest < Minitest::Test

  def setup
    game_path       = './data/sample/game_sample.csv'
    team_path       = './data/actual/team_info.csv'
    game_teams_path = './data/sample/game_teams_stats_sample.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(locations)
  end

  def test_it_exists
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_generates_games
    @stat_tracker.games.each{|game| assert_instance_of(Game, game)}
  end

  def test_generates_teams
    @stat_tracker.teams.each{|team| assert_instance_of(Team, team)}
  end

  def test_returns_highest_total_score
    assert_equal 7, @stat_tracker.highest_total_score
  end
  #
  def test_returns_lowest_total_score
    assert_equal 1, @stat_tracker.lowest_total_score
  end
  #
  def test_returns_biggest_blowout
    assert_equal 5, @stat_tracker.biggest_blowout
  end
  #
  def test_returns_percentage_home_wins
    assert_equal 0.5, @stat_tracker.percentage_home_wins
  end
  #
  def test_returns_percentage_away_wins
    assert_equal 0.5, @stat_tracker.percentage_away_wins
  end
  #
  # def test_returns_count_of_game_by_season
  #   expected = {
  #     '20122013' => 4,
  #     '20152016' => 4
  #   }
  #   assert_equal expected, @stat_tracker.count_of_games_by_season
  # end
  #
  # def test_returns_average_goals_per_game
  #   assert_equal 4.38, @stat_tracker.average_goals_per_game
  # end
  #
  # def test_returns_average_goals_by_season
  #   expected = {
  #     '20122013' => 5.5,
  #     '20152016' => 3.25
  #   }
  #   assert_equal expected, @stat_tracker.average_goals_by_season
  # end
  #
  # def test_returns_count_of_teams
  #   assert_equal 33, @stat_tracker.count_of_teams
  # end
  #
  # def test_returns_best_offense
  #   assert_equal "Lightning", @stat_tracker.best_offense
  # end
  #
  # def test_returns_worst_offense
  #   assert_equal "Wild", @stat_tracker.worst_offense
  # end
  #
  # def test_returns_best_defense
  #   assert_equal "Stars", @stat_tracker.best_defense
  # end
  #
  # def test_returns_worst_defense
  #   assert_equal "Lightning", @stat_tracker.worst_defense
  # end
  #
  # def test_returns_highest_scoring_visitor
  #   assert_equal "Rangers", @stat_tracker.highest_scoring_visitor
  # end
  #
  # def test_returns_highest_scoring_home_team
  #   assert_equal "Lightning", @stat_tracker.highest_scoring_home_team
  # end
  #
  # def test_returns_lowest_scoring_visitor
  #   assert_equal "Wild", @stat_tracker.lowest_scoring_vistor
  # end
  #
  # def test_returns_lowest_scoring_home_team
  #   assert_equal "Lightning", @stat_tracker.lowest_scoring_home_team
  # end
  #
  # def test_returns_winningest_team
  #   #hard saying not knowing
  #   assert_equal "Bruins", @stat_tracker.winningest_team
  # end
  #
  # def test_returns_best_fans
  #   assert_equal "Bruins", @stat_tracker.best_fans
  # end
  #
  # def test_returns_worst_fans
  #   assert_equal "", @stat_tracker.worst_fans
  # end
end
