require "./test/test_helper"


class GameStatisticsTest < Minitest::Test

  def setup
    game_path       = './data/sample/game_sample.csv'
    team_path       = './data/sample/team_info_sample.csv'
    game_teams_path = './data/sample/game_teams_stats_sample.csv'

    locations = {
      games:      game_path,
      teams:      team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.new
    @stat_tracker.from_csv(locations)
  end

  def test_returns_highest_total_score
    assert_equal 7, @stat_tracker.highest_total_score
  end

  def test_returns_lowest_total_score
    assert_equal 1, @stat_tracker.lowest_total_score
  end

  def test_returns_biggest_blowout
    assert_equal 5, @stat_tracker.biggest_blowout
  end

  def test_returns_percentage_home_wins
    assert_equal 0.5, @stat_tracker.percentage_home_wins
  end

  def test_returns_percentage_away_wins
    assert_equal 0.5, @stat_tracker.percentage_away_wins
  end

  def test_returns_count_of_game_by_season
    expected = {
      '20122013' => 4,
      '20152016' => 4
    }
    assert_equal expected, @stat_tracker.count_of_games_by_season
  end

  def test_returns_average_goals_per_game
    assert_equal 4.38, @stat_tracker.average_goals_per_game
  end

  def test_returns_average_goals_by_season
    expected = {
      '20122013' => 5.5,
      '20152016' => 3.25
    }
    assert_equal expected, @stat_tracker.average_goals_by_season
  end

end
