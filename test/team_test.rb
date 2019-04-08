require 'minitest/autorun'
require 'minitest/pride'
require './lib/team'
require './lib/game'
require 'mocha/minitest'

class TeamTest < Minitest::Test

  def setup
    team_info = {team_id: 1, franchiseid: 23, shortname: "New Jersey", teamname: "Devils", abbreviation: "NJD", link: "/api/v1/teams/1"}
    @team = Team.new(team_info)

    game_info_1 = {game_id: 2012030221, season: 20122013, type: "P", date_time: "2013-05-10", away_team_id: 1, home_team_id: 3, away_goals: 2, home_goals: 3, outcome: "home win OT", home_rink_side_start: "left", venue: "TD Garden", venue_link: "/api/v1/venues/null", venue_time_zone_id: "America/New_York", venue_time_zone_offset: -4, venue_time_zone_tz: "EDT"}
    @game_1 = Game.new(game_info_1)

    game_info_2 = {game_id: 2012030222, season: 20122013, type: "P", date_time: "2013-05-12", away_team_id: 6, home_team_id: 1, away_goals: 2, home_goals: 3, outcome: "home win OT", home_rink_side_start: "left", venue: "TD Garden", venue_link: "/api/v1/venues/null", venue_time_zone_id: "America/New_York", venue_time_zone_offset: -4, venue_time_zone_tz: "EDT"}
    @game_2 = Game.new(game_info_2)

    game_info_3 = {game_id: 2012030223, season: 20122013, type: "P", date_time: "2013-05-14", away_team_id: 1, home_team_id: 6, away_goals: 2, home_goals: 3, outcome: "home win OT", home_rink_side_start: "left", venue: "TD Garden", venue_link: "/api/v1/venues/null", venue_time_zone_id: "America/New_York", venue_time_zone_offset: -4, venue_time_zone_tz: "EDT"}
    @game_3 = Game.new(game_info_3)

    game_info_4 = {game_id: 2012030224, season: 20122013, type: "P", date_time: "2013-05-16", away_team_id: 3, home_team_id: 1, away_goals: 2, home_goals: 3, outcome: "home win OT", home_rink_side_start: "left", venue: "TD Garden", venue_link: "/api/v1/venues/null", venue_time_zone_id: "America/New_York", venue_time_zone_offset: -4, venue_time_zone_tz: "EDT"}
    @game_4 = Game.new(game_info_4)

    @team.add(@game_1)
    @team.add(@game_2)
    @team.add(@game_3)
    @team.add(@game_4)
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

    assert_equal [@game_1, @game_2, @game_3, @game_4], @team.games
  end

  def test_can_generate_seasons

    @team.generate_seasons

    assert_equal 1, @team.seasons.length
  end

  def test_returns_win_percentage
    assert_equal 0.5, @team.win_percentage
  end

  def test_returns_home_win_percentage
    assert_equal 1.0, @team.home_win_percentage
  end

  def test_returns_away_win_percentage
    assert_equal 0.0, @team.away_win_percentage
  end

  def test_returns_win_percentage_versus_rival

    game_team_1 = mock
    game_team_1.stubs(won: "TRUE", team_id: 1)
    @game_1.add(game_team_1)
    game_team_2 = mock
    game_team_2.stubs(won: "TRUE", team_id: 1)
    @game_2.add(game_team_2)
    game_team_3 = mock
    game_team_3.stubs(won: "TRUE", team_id: 1)
    @game_3.add(game_team_3)
    game_team_4 = mock
    game_team_4.stubs(won: "FALSE", team_id: 1)
    @game_4.add(game_team_4)
    assert_equal 0.5, @team.win_percentage_versus(3)
  end



end
