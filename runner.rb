require './lib/stat_tracker'

game_path = './data/sample/game_sample.csv'
team_path = './data/actual/team_info.csv'
game_teams_path = './data/sample/game_teams_stats_sample.csv'

locations = {
  games: game_path,
  teams: team_path,
  game_teams: game_teams_path
}

stat_tracker = StatTracker.from_csv(locations)

require 'pry'; binding.pry
