require 'csv'
require "./lib/game"
require "./lib/team"

class StatTracker
  attr_reader :games, :seasons, :teams
  def initialize(games_table, teams_table, season_table)
    @seasons = {}
    @games = generate_games(games_table)
    @teams = generate_teams(teams_table)
  end

  def self.from_csv(locations)
    games_table = CSV.table(locations[:games], options = Hash.new)
    teams_table = CSV.table(locations[:teams], options = Hash.new)
    seasons_table = CSV.table(locations[:game_teams], options = Hash.new)
    self.new(games_table, teams_table, seasons_table)
  end

  def generate_games(games_table)
    @games = games_table.map{|game_info| Game.new(game_info)}
  end

  def generate_teams(teams_table)
    @teams = teams_table.map{|team_info| Team.new(team_info)}
  end

  def highest_total_score
    @games.max_by{|game|game.score}.score
  end

  def lowest_total_score
    @games.min_by{|game|game.score}.score
  end

  def biggest_blowout
    @games.max_by{|game|game.score_differential}.score_differential
  end

  def percentage_home_wins
    @games.count{|game| game.outcome.include?("home")} / @games.count.to_f
  end

  def percentage_away_wins
    @games.count{|game| game.outcome.include?("away")} / @games.count.to_f
  end

  def count_of_games_by_season
    hash = {}
    @games.each do |game|
      unless hash.keys.include?(game.season)
        hash[game.season] = 1
      else
        hash[game.season] +=1
      end
    end
    hash
  end

end
