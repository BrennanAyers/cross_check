require "./test/test_helper"

class LeagueStatisticsTest < MiniTest::Test

  def setup
    game_path       = './data/sample/game_sample.csv'
    team_path       = './data/actual/team_info.csv'
    game_teams_path = './data/sample/game_teams_stats_sample.csv'

    locations = {
      games:      game_path,
      teams:      team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.new
    @stat_tracker.from_csv(locations)
  end

  def test_returns_count_of_teams
    assert_equal 33, @stat_tracker.count_of_teams
  end

  def test_returns_best_offense
    assert_equal "Lightning", @stat_tracker.best_offense
  end

  def test_returns_worst_offense
    assert_equal "Wild", @stat_tracker.worst_offense
  end

  def test_returns_best_defense
    assert_equal "Stars", @stat_tracker.best_defense
  end

  def test_returns_worst_defense
    assert_equal "Lightning", @stat_tracker.worst_defense
  end
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
