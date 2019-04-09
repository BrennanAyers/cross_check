require './lib/stat_tracker'
require './lib/stat_tracker_2'

game_path = './data/actual/game.csv'
team_path = './data/actual/team_info.csv'
game_teams_path = './data/actual/game_teams_stats.csv'

locations = {
  games: game_path,
  teams: team_path,
  game_teams: game_teams_path
}


stat_tracker = StatTracker.from_csv(locations)

require 'benchmark'

array = (1..1000000).map { rand }

require "pry"; binding.pry
require 'benchmark'
Benchmark.bmbm do |x|
  x.report("base") { StatTracker.from_csv(locations) }
  # x.report("hash") { StatTracker2.from_csv(locations) }
end
