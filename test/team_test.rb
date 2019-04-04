require 'minitest/autorun'
require 'minitest/pride'
require './lib/team'
require "./lib/game"
class TeamTest < Minitest::Test
  def setup
    info = {team_id: 1, franchiseid: 23, shortname: "New Jersey", teamname: "Devils", abbreviation: "NJD", link: "/api/v1/teams/1"}
    @team = Team.new(info)
    @game = Game.new(info = {game_id: 2012030221, season: 20122013, type: "P", date_time: "2013-05-16", away_team_id: 3, home_team_id: 6, away_goals: 2, home_goals: 3, outcome: "home win OT", home_rink_side_start: "left", venue: "TD Garden", venue_link: "/api/v1/venues/null", venue_time_zone_id: "America/New_York", venue_time_zone_offset: -4, venue_time_zone_tz: "EDT"})
  end

  def test_it_exists
    assert_instance_of Team, @team
  end

  def test_has_correct_information
    assert_equal 1, @team.id
    assert_equal 23, @team.franchiseid
    assert_equal "New Jersey", @team.shortname
    assert_equal "Devils", @team.teamname
    assert_equal "NJD", @team.abbreviation
    assert_equal "/api/v1/teams/1", @team.link

  end

  def test_can_add_game
    @team.add(@game)
    assert_equal [@game], @team.games
  end
end
