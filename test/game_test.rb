require './test/test_helper'

class GameTest < Minitest::Test
  def setup
    info = {
      game_id: 2012030221,
      season: 20122013,
      type: "P",
      date_time: "2013-05-16",
      away_team_id: 3,
      home_team_id: 6,
      away_goals: 2,
      home_goals: 3,
      outcome: "home win OT",
      }
    @game = Game.new(info)
  end

  def test_it_exists
    assert_instance_of Game, @game
  end

  def test_has_correct_information
    assert_equal 2012030221, @game.id
    assert_equal '20122013', @game.season
    assert_equal "P", @game.type
    assert_equal "2013-05-16", @game.date_time
    assert_equal 3, @game.away_team_id
    assert_equal 6, @game.home_team_id
    assert_equal 2, @game.away_goals
    assert_equal 3, @game.home_goals
    assert_equal "home win OT", @game.outcome

    assert_equal 5, @game.score
  end

  def test_returns_score_differential
    assert_equal 1, @game.score_differential
  end

  def test_team_stats_starts_empty_can_add_to
    assert_equal [], @game.team_stats
    game_team = mock
    game_team_2 = mock
    @game.add(game_team)
    @game.add(game_team_2)
    assert_equal [game_team, game_team_2], @game.team_stats
  end

  def test_returns_winners_id
    assert_equal 6, @game.winners_id
  end

  def test_returns_losers_id
    assert_equal 3, @game.losers_id
  end

  def test_returns_goals_for_a_team
    assert_equal 2, @game.goals_for_team(3)
    assert_equal 3, @game.goals_for_team(6)
  end

  def test_returns_rival_team_goals
    assert_equal 2, @game.goals_for_rival_team(6)
  end

end
