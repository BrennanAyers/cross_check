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
    games.select {|game| game.type == "R" }
  end

  def post_season_sort(games)
    games.select {|game| game.type == "P" }
  end

  # def win_percentage
  #   games.count {|game| game.}
  # end

end
