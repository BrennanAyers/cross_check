require_relative './team_specific_stats'

class Season
  include TeamSpecificStats

  attr_reader :regular_season_games,
              :post_season_games,
              :games,
              :team_id

  def initialize(games, team_id)
    @regular_season_games = regular_season_sort(games)
    @post_season_games    = post_season_sort(games)
    @games                = games
    @team_id              = team_id
  end

  def regular_season_sort(games)
    games.select {|game| game.type == "R"}
  end

  def post_season_sort(games)
    games.select {|game| game.type == "P"}
  end

  def win_percentage
    games.count {|game| our_stats_in_game(game).won == "TRUE"}.fdiv(games.length)
  end

  def regular_season_win_percentage
    regular_season_games.count {|game| our_stats_in_game(game).won == "TRUE"}.fdiv(regular_season_games.length).round(2)
  end

  def post_season_win_percentage
    post_season_games.count {|game| our_stats_in_game(game).won == "TRUE"}.fdiv(post_season_games.length)
  end

  def shot_accuracy
    shots = games.sum {|game| our_stats_in_game(game).shots}
    goals = games.sum {|game| our_stats_in_game(game).goals}
    goals.fdiv(shots).round(2)
  end

  def number_of_hits
    games.sum {|game| our_stats_in_game(game).hits}
  end

  def power_play_goal_percentage
    power_play_goals = games.sum {|game| our_stats_in_game(game).powerplaygoals}
    goals = games.sum {|game| our_stats_in_game(game).goals}
    power_play_goals.fdiv(goals).round(2)
  end

  def regular_season_goals
    regular_season_games.sum {|game| our_stats_in_game(game).goals}
  end

  def post_season_goals
    post_season_games.sum {|game| our_stats_in_game(game).goals}
  end

end
