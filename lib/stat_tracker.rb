require 'csv'

class StatTracker

  def initialize(games_table, teams_table, season_table)
    @games = {}
    games_table.each do |game|
      @games[game[:game_id]] = Game.new(game)
    end
  end

  def self.from_csv(locations)
    games_table = CSV.table(locations[:games], options = Hash.new)


  end
end
