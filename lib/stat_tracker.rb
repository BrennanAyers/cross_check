require 'csv'
require "./lib/game"
require "./lib/team"

class StatTracker
  attr_reader :games, :game_teams, :teams
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

  def generate_games(games_table)
    @games = games_table.map{|game_info| Game.new(game_info)}
    @games.each do |game|
      @game_teams.each{|game_team|game.add(game_team) if game.id == game_team.game_id}
    end
  end

  def generate_teams(teams_table)
    @teams = teams_table.map{|team_info| Team.new(team_info)}
    @teams.each do |team|
      @games.each{|game|team.add(game) if game.away_team_id == team.id || game.home_team_id == team.id}
    end

  end

  def generate_game_teams(game_teams_table)
    @game_teams = game_teams_table.map{|game_team_info| GameTeam.new(game_team_info)}
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

  def average_goals_per_game
    total_score = @games.reduce(0) do |total,game|
      total + game.score
    end
    total_score.fdiv(@games.length).round(2)
  end

  def average_goals_by_season
    hash = {}
    @games.each do |game|
      unless hash.keys.include?(game.season)
        hash[game.season] = [game.score]
      else
        hash[game.season] << game.score
      end
    end
    hash.transform_values{|scores| scores.sum.fdiv(scores.length)}
  end

#It3

  def count_of_teams
    @teams.count
  end

  def best_offense
    best_team = @teams.max_by do |team|
      team_goals = team.games.map{|game|(team.our_stats_in_game(game).goals)}
      team_goals.sum.fdiv(team.games.count)
    end
    best_team.teamname
  end

  def worst_offense
    worst_team = @teams.min_by do |team|
      team_goals = team.games.map{|game|(team.our_stats_in_game(game).goals)}
      team_goals.sum.fdiv(team.games.count)
    end
    worst_team.teamname
  end

  def best_defense
    team = @teams.min_by do |team|
      game_goals = team.games.map{|game|
        team.rival_stats_in_game(game).goals}
      game_goals.sum.fdiv(game_goals.length)
    end
    team.teamname
  end

  def worst_defense
    team = @teams.max_by do |team|
      game_goals = team.games.map{|game|
        team.rival_stats_in_game(game).goals}
      game_goals.sum.fdiv(game_goals.length)
    end
    team.teamname
  end
end
