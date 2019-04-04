require 'minitest/autorun'
require 'minitest/pride'
require './lib/team'
class TeamTest < Minitest::Test
  def setup
    info = {team_id: 1, franchiseid: 23, shortname: "New Jersey", teamname: "Devils", abbreviation: "NJD", link: "/api/v1/teams/1"}
    @team = Team.new(info)
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
end
