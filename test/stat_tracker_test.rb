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

    @stat_tracker = StatTracker.new
    @stat_tracker.from_csv(locations)
  end

  def test_it_exists
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_reads_csv_games
    expected = {2012030221=>{:season=>20122013, :home_goals=>3, :away_goals=>2, :outcome=>"home win OT"}, 2012030222=>{:season=>20122013, :home_goals=>5, :away_goals=>2, :outcome=>"home win REG"}, 2012030223=>{:season=>20122013, :home_goals=>1, :away_goals=>2, :outcome=>"away win REG"}, 2012030224=>{:season=>20122013, :home_goals=>4, :away_goals=>3, :outcome=>"home win OT"}, 2015030133=>{:season=>20152016, :home_goals=>1, :away_goals=>6, :outcome=>"away win REG"}, 2015030134=>{:season=>20152016, :home_goals=>2, :away_goals=>1, :outcome=>"home win REG"}, 2015030135=>{:season=>20152016, :home_goals=>0, :away_goals=>2, :outcome=>"away win REG"}, 2015030136=>{:season=>20152016, :home_goals=>0, :away_goals=>1, :outcome=>"away win REG"}}

    assert_equal expected, @stat_tracker.game_stats
  end

  def test_reads_csv_teams
    skip
    expected = {1=>{:franchise_id=>23, :short_name=>"New Jersey", :team_name=>"Devils", :abbreviation=>"NJD"}, 4=>{:franchise_id=>16, :short_name=>"Philadelphia", :team_name=>"Flyers", :abbreviation=>"PHI"}, 26=>{:franchise_id=>14, :short_name=>"Los Angeles", :team_name=>"Kings", :abbreviation=>"LAK"}, 14=>{:franchise_id=>31, :short_name=>"Tampa Bay", :team_name=>"Lightning", :abbreviation=>"TBL"}}

    assert_equal expected, @stat_tracker.team_stats
  end

end
