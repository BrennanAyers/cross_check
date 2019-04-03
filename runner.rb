require './lib/stat_tracker'

game_path = './data/sample/game_sample.csv'
team_path = './data/sample/team_info_sample.csv'
game_teams_path = './data/sample/game_teams_stats_sample.csv'

locations = {
  games: game_path,
  teams: team_path,
  game_teams: game_teams_path
}

stat_tracker = StatTracker.new

stat_tracker.from_csv(locations)

require 'pry'; binding.pry
