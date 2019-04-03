require 'csv'

class StatTracker

  def initialize(games_table, teams_table, season_table)
    @seasons = {}
    number_of_seasons = games_table.map do |row|
      row[:season]
    end.uniq!
    generate_seasons(seasons_table, teams_table, games_table, number_of_seasons)
  end

  def self.from_csv(locations)
    games_table = CSV.table(locations[:games], options = Hash.new)
    teams_table = CSV.table(locations[:teams], options = Hash.new)
    seasons_table = CSV.table(locations[:game_teams], options = Hash.new)
    initialize(games_table, teams_table, seasons_table)
  end

  def generate_games(games_table)
    games_table.each do |game|
      @games[game[:game_id]] = Game.new(game)
    end
  end

  def generate_teams(teams_table)
    teams_table.each do |team|
      @teams[team[:team_id]] = Team.new(team)
    end
  end

  def generate_seasons(seasons_table, teams_table, games_table, number_of_seasons)
    number_of_seasons.each do |season|
      @seasons[season] = Season.new(seasons_table, teams_table, games_table)
    end
  end
end
