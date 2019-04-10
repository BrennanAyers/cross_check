require_relative './team_specific_stats'

class Season
  include TeamSpecificStats

  attr_reader :regular_season_games,
              :post_season_games,
              :games,
              :team_id,
              :id

  def initialize(games, team_id, season_id)
    @regular_season_games = regular_season_sort(games)
    @post_season_games    = post_season_sort(games)
    @games                = games
    @team_id              = team_id
    @id                   = season_id
  end

  def regular_season_sort(games)
    games.select {|game| game.type == "R"}
  end

  def post_season_sort(games)
    games.select {|game| game.type == "P"}
  end

  def win_percentage
    games.count {|game| our_stats_in_game(game, @team_id).won == "TRUE"}.fdiv(games.length)
  end

  def regular_season_win_percentage
    regular_season_games.count {|game| our_stats_in_game(game, @team_id).won == "TRUE"}.fdiv(regular_season_games.length).round(2)
  end

  def post_season_win_percentage
    avg = post_season_games.count {|game| our_stats_in_game(game, @team_id).won == "TRUE"}.fdiv(post_season_games.length).round(2)
    avg.nan? ? 0.0 : avg
  end

  def shot_accuracy
    shots = games.sum {|game| our_stats_in_game(game, @team_id).shots}
    goals = games.sum {|game| our_stats_in_game(game, @team_id).goals}
    goals.fdiv(shots).round(2)
  end

  def number_of_hits
    games.sum {|game| our_stats_in_game(game, @team_id).hits}
  end

  def all_goals
    games.sum {|game| our_stats_in_game(game, @team_id).goals}
  end

  def power_play_goals
    games.sum {|game| our_stats_in_game(game, @team_id).powerplaygoals}
  end

  def regular_season_goals
    regular_season_games.sum {|game| our_stats_in_game(game, @team_id).goals}
  end

  def post_season_goals
    post_season_games.sum {|game| our_stats_in_game(game, @team_id).goals}
  end

  def regular_season_goals_against
    regular_season_games.sum {|game| rival_stats_in_game(game, @team_id).goals}
  end

  def post_season_goals_against
    post_season_games.sum {|game| rival_stats_in_game(game, @team_id).goals}
  end

  def regular_season_average_goals
    regular_season_goals.fdiv(regular_season_games.length).round(2)
  end

  def post_season_average_goals
    avg = post_season_goals.fdiv(post_season_games.length).round(2)
    avg.nan? ? 0.0 : avg
  end

  def regular_season_average_goals_against
    regular_season_goals_against.fdiv(regular_season_games.length).round(2)
  end

  def post_season_average_goals_against
    avg = post_season_goals_against.fdiv(post_season_games.length).round(2)
    avg.nan? ? 0.0 : avg
  end

  def coach_name
    our_stats_in_game(games.first, @team_id).head_coach
  end

end
