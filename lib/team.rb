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
      @seasons << Season.new(games_in_season, @id, season)
    end
  end

  def number_of_home_games
    @games.count{|game| game.home_team_id == @id}
  end

  def number_of_away_games
    @games.count{|game| game.away_team_id == @id}
  end

  def win_percentage
    @games.count do |game|
      game.home_team_id == @id && game.outcome.start_with?('home') || game.away_team_id == @id && game.outcome.start_with?('away')
    end.fdiv(@games.count).round(2)
  end

  def home_win_percentage
    @games.count do |game|
      game.home_team_id == @id && game.outcome.start_with?('home')
    end.fdiv(number_of_home_games).round(2)
  end

  def away_win_percentage
    @games.count do |game|
      game.away_team_id == @id && game.outcome.start_with?('away')
    end.fdiv(number_of_away_games).round(2)
  end

  def win_percentage_versus(rival_id)
    rival_games = @games.select{|game| game.home_team_id == rival_id || game.away_team_id == rival_id}
    win_count = rival_games.count{|game| our_stats_in_game(game, @id).won == "TRUE"}
    win_count.fdiv(rival_games.size).round(2)
  end

  def coach_by_season(season_id)
    @seasons.find {|season| season.id.to_s == season_id}.coach_name
  end

end
