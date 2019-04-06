require './lib/stat_tracker'

game_path = './data/actual/game.csv'
team_path = './data/actual/team_info.csv'
game_teams_path = './data/actual/game_teams_stats.csv'

locations = {
  games: game_path,
  teams: team_path,
  game_teams: game_teams_path
}


stattrack = StatTracker.from_csv(locations)

require 'pry'; binding.pry
