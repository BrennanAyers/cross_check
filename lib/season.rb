class Season
  attr_reader :regular_season_games,
              :post_season_games,
              :games

  def initialize(games)
    @regular_season_games = regular_season_sort(games)
    @post_season_games    = post_season_sort(games)
    @games                = games
  end

  def regular_season_sort(games)
    games.select {|game| game.type == "R" }
  end

  def post_season_sort(games)
    games.select {|game| game.type == "P" }
  end

end
