require 'csv'
require_relative './game_team'
require_relative './game'
require_relative './team'
require_relative './team_specific_stats'
require_relative './game_stats'
require_relative './league_stats'
require_relative './team_stats'
require_relative './season_stats'

class StatTracker
  include TeamSpecificStats, GameStats, LeagueStats, TeamStats, SeasonStats
  attr_reader :games,
              :game_teams,
              :teams

  def initialize(games_table, teams_table, game_teams_table)
    @game_teams = generate_game_teams(game_teams_table)
    @games = generate_games(games_table)
    @teams = generate_teams(teams_table)
  end

  def self.from_csv(locations)
    games_table = CSV.table(locations[:games], options = Hash.new)
    teams_table = CSV.table(locations[:teams], options = Hash.new)
    game_teams_table = CSV.table(locations[:game_teams], options = Hash.new)
    self.new(games_table, teams_table, game_teams_table)
  end

  def generate_game_teams(game_teams_table)
    @game_teams = game_teams_table.map{|game_team_info| GameTeam.new(game_team_info)}
  end

  def generate_games(games_table)
    @games = games_table.map{|game_info| Game.new(game_info)}
    @games.each do |game|
      @game_teams.each{|game_team|game.add(game_team) if game.id == game_team.game_id}
    end
  end

end
