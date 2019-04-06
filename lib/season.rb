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
    regular_season_games.count {|game| our_stats_in_game(game).won == "TRUE"}.fdiv(regular_season_games.length)
  end

  def post_season_win_percentage
    post_season_games.count {|game| our_stats_in_game(game).won == "TRUE"}.fdiv(post_season_games.length)
  end

  def shot_accuracy
    shots = games.sum {|game| our_stats_in_game(game).shots}
    goals = games.sum {|game| our_stats_in_game(game).goals}
    goals / shots
  end

  def number_of_hits
    games.sum {|game| our_stats_in_game(game).hits}
  end



end
