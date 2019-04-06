require_relative './season'
require_relative './team_specific_stats'

class Team
  include TeamSpecificStats

  attr_reader :id,
              :franchiseid,
              :shortname,
              :teamname,
              :abbreviation,
              :link,
              :games,
              :seasons

  def initialize(info)
    @id           = info[:team_id]
    @franchiseid  = info[:franchiseid]
    @shortname    = info[:shortname]
    @teamname     = info[:teamname]
    @abbreviation = info[:abbreviation]
    @link         = info[:link]
    @games        = []
    @seasons      = []
  end

  def add(game)
    @games << game
  end

  def generate_seasons
    seasons_played = @games.map {|game| game.season }.uniq
    seasons_played.each do |season|
      games_in_season = @games.select do |game|
        game.season == season
      end
      @seasons << Season.new(games_in_season, @id)
    end
  end

  ##NO TESTS##

  def number_of_home_games
    @games.count{|game| game.home_team_id == @id}
  end

  def number_of_away_games
    @games.count{|game| game.away_team_id == @id}
  end

  def home_win_percentage
    @games.count do |game|
      our_stats_in_game(game, @id).hoa == "home" && our_stats_in_game(game, @id).won == "TRUE"
    end.fdiv(number_of_home_games)
  end

  def away_win_percentage
    @games.count do |game|
      our_stats_in_game(game, @id).hoa == "away" && our_stats_in_game(game, @id).won == "TRUE"
    end.fdiv(number_of_away_games)
  end

end
