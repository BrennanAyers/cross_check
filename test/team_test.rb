require 'minitest/autorun'
require 'minitest/pride'
require './lib/team'
require './lib/game'
require 'mocha/minitest'

class TeamTest < Minitest::Test

  def setup
    info = {team_id: 1, franchiseid: 23, shortname: "New Jersey", teamname: "Devils", abbreviation: "NJD", link: "/api/v1/teams/1"}
    @team = Team.new(info)
    @game = mock("Game 1")
    @game.stubs(season: "20122013", type: "R")
    @game_2 = mock("Game 2")
    @game_2.stubs(season: "20132014", type: "R")
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
    @team.add(@game_2)
    assert_equal [@game, @game_2], @team.games
  end

  def test_can_generate_seasons
    @team.add(@game)
    @team.add(@game_2)
    @team.generate_seasons

    assert_equal 2, @team.seasons.length
  end

#Maybe inadequate
  # def test_finds_own_stats
  #
  #   game_stat = mock(team_id: 1)
  #   game_stat_2 = mock(team_id: 3)
  #   assert_equal game_stat, [game_stat,
  #   game_stat_2].select{|stats| stats.team_id == 1}.pop
  # end
  #
  # def test_finds_rival_stats
  #   game_stat = mock(team_id: 1)
  #   game_stat_2 = mock(team_id: 3)
  #   assert_equal game_stat_2, [game_stat,
  #   game_stat_2].select{|stats| stats.team_id == 3}.pop
  # end

end
