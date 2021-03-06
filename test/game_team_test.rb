require './test/test_helper'

class GameTeamTest < Minitest::Test
  def setup
    info = {
      game_id: 2012030221,
      team_id: 3,
      hoa: "away",
      won: "FALSE",
      settled_in: "OT",
      head_coach: "John Tortorella",
      goals: 2,
      shots: 35,
      hits: 44,
      powerplaygoals: 0}
    @game_team = GameTeam.new(info)
  end

  def test_has_correct_information
   assert_equal 2012030221, @game_team.game_id
   assert_equal 3, @game_team.team_id
   assert_equal 'away', @game_team.hoa
   assert_equal 'FALSE', @game_team.won
   assert_equal 'OT', @game_team.settled_in
   assert_equal "John Tortorella", @game_team.head_coach
   assert_equal 2, @game_team.goals
   assert_equal 35, @game_team.shots
   assert_equal 44, @game_team.hits
   assert_equal 0, @game_team.powerplaygoals
  end

end
