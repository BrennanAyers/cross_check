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

  def test_reads_csv_games
    expected =

    assert_equal expected, @stat_tracker.game_stats
  end

  def test_reads_csv_teams
    skip
    expected = 

    assert_equal expected, @stat_tracker.team_stats
  end

end
