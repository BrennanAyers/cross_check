require 'csv'
require_relative './game_team'
require_relative './game'
require_relative './team'
require_relative './team_specific_stats'

class StatTracker
  include TeamSpecificStats
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

  def generate_teams(teams_table)
    @teams = teams_table.map{|team_info| Team.new(team_info)}
    @teams.each do |team|
      @games.each{|game|team.add(game) if game.away_team_id == team.id || game.home_team_id == team.id}
      team.generate_seasons
    end
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
    (@games.count{|game| game.outcome.include?("home")} / @games.count.to_f).round(2)
  end

  def percentage_visitor_wins
    (@games.count{|game| game.outcome.include?("away")} / @games.count.to_f).round(2)
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
    hash.transform_values{|scores| scores.sum.fdiv(scores.length).round(2)}
  end

#It3

  def count_of_teams
    @teams.count
  end

  def best_offense
    best_team = @teams.max_by do |team|
      team.games.map{|game|game.goals_for_team(team.id)}.sum.fdiv(team.games.count)
    end
    best_team.teamname
  end

  def worst_offense
    worst_team = @teams.min_by do |team|
      team_goals = team.games.map{|game|(team.our_stats_in_game(game, team.id).goals)}
      team_goals.sum.fdiv(team.games.count)
    end
    worst_team.teamname
  end

  def best_defense
    best_team = @teams.min_by do |team|
      game_goals = team.games.map{|game|
        team.rival_stats_in_game(game, team.id).goals}
      game_goals.sum.fdiv(game_goals.length)
    end
    best_team.teamname
  end

  def worst_defense
    worst_team = @teams.max_by do |team|
      game_goals = team.games.map{|game|
        team.rival_stats_in_game(game, team.id).goals}
      game_goals.sum.fdiv(game_goals.length)
    end
    worst_team.teamname
  end

  def highest_scoring_visitor
    best_visitor = @teams.max_by do |team|
      away_games = @games.select{|game| team.id == game.away_team_id}
      away_goals = away_games.map{|game| game.away_goals }
      away_goals.sum.fdiv(away_games.count)
    end
    best_visitor.teamname
  end

  def highest_scoring_home_team
    best_home = @teams.max_by do |team|
      home_games = @games.select{|game| team.id == game.home_team_id}
      home_goals = home_games.map{|game| game.home_goals }
      home_goals.sum.fdiv(home_games.count)
    end
    best_home.teamname
  end

  def lowest_scoring_visitor
    worst_visitor = @teams.min_by do |team|
      away_games = @games.select{|game| team.id == game.away_team_id}
      away_goals = away_games.map{|game| game.away_goals }
      away_goals.sum.fdiv(away_games.count)
    end
    worst_visitor.teamname
  end

  def lowest_scoring_home_team
    worst_home = @teams.min_by do |team|
      home_games = @games.select{|game| team.id == game.home_team_id}
      home_goals = home_games.map{|game| game.home_goals }
      home_goals.sum.fdiv(home_games.count)
    end
    worst_home.teamname
  end

  def winningest_team
    winningest = @teams.max_by do |team|
      team_wins = team.games.select{|game|(team.our_stats_in_game(game, team.id).won == "TRUE")}
      team_wins.count.fdiv(team.games.count)
    end
    winningest.teamname
  end

  def best_fans
    best_team = @teams.max_by do |team|
      (team.home_win_percentage - team.away_win_percentage).abs
    end
    best_team.teamname
  end

  def worst_fans
    @teams.select do |team|
      team.home_win_percentage < team.away_win_percentage
    end.map(&:teamname)
  end

  def find_team(team_id)
    @teams.find {|team| team.id.to_s == team_id}
  end

  def team_info(team_id)
    team = find_team(team_id)
    {"team_id" => team.id.to_s, "franchise_id" => team.franchiseid.to_s, "short_name" => team.shortname, "team_name" => team.teamname, "abbreviation" => team.abbreviation, "link" => team.link}
  end

  def best_season(team_id)
    team = find_team(team_id)
    best_season = team.seasons.max_by {|season| season.win_percentage}
    best_season.id
  end

  def worst_season(team_id)
    team = find_team(team_id)
    worst_season = team.seasons.min_by {|season| season.win_percentage}
    worst_season.id
  end

  def average_win_percentage(team_id)
    find_team(team_id).win_percentage
  end

  def most_goals_scored(team_id)
    team = find_team(team_id)
    game = team.games.max_by{|game|team.our_stats_in_game(game, team.id).goals}
    our_stats_in_game(game, team.id).goals
  end

  def fewest_goals_scored(team_id)
    team = find_team(team_id)
    game = team.games.min_by{|game|team.our_stats_in_game(game, team.id).goals}
    our_stats_in_game(game, team.id).goals
  end

  def favorite_opponent(team_id)
    focus = find_team(team_id)
    teams = @teams - [focus]
    teams.max_by {|team|
       focus.win_percentage_versus(team.id)}.teamname
  end

  def rival(team_id)
    focus = find_team(team_id)
    teams = @teams - [focus]
    teams.min_by {|team| focus.win_percentage_versus(team.id)}.teamname
  end

  def biggest_team_blowout(team_id)
    team = find_team(team_id)
    team.games.max_by do |game|
      our_goals = team.our_stats_in_game(game, team.id).goals
      their_goals = game.score - our_goals
      our_goals - their_goals
    end.score_differential
  end

  def worst_loss(team_id)
    team = find_team(team_id)
    team.games.min_by do |game|
      our_goals = team.our_stats_in_game(game, team.id).goals
      their_goals = game.score - our_goals
      our_goals - their_goals
    end.score_differential
  end

  def head_to_head(team_id)
    hash = {}
    focus = find_team(team_id)
    teams = @teams - [focus]

    teams.each do |team|
      hash[team.teamname] = focus.win_percentage_versus(team.id)
    end
    hash
  end

  def seasonal_summary(team_id)
    hash = {}
    team = find_team(team_id)
    team.seasons.each do |season|
      hash[season.id] = {
        postseason: {
          win_percentage: season.post_season_win_percentage,
          total_goals_scored: season.post_season_goals,
          total_goals_against: season.post_season_goals_against,
          average_goals_scored: season.post_season_average_goals,
          average_goals_against: season.post_season_average_goals_against
        },
        regular_season: {
          win_percentage: season.regular_season_win_percentage,
          total_goals_scored: season.regular_season_goals,
          total_goals_against: season.regular_season_goals_against,
          average_goals_scored: season.regular_season_average_goals,
          average_goals_against: season.regular_season_average_goals_against
        }
      }
    end
    hash
  end

  def biggest_bust(season_id)
    teams = @teams.select {|team| team.seasons.any? {|season| season.id.to_s == season_id}}
    teams.max_by do |team|
      focus = team.seasons.find {|season| season.id.to_s == season_id}
      focus.regular_season_win_percentage - focus.post_season_win_percentage
    end.teamname
  end

  def biggest_surprise(season_id)
    teams = @teams.select {|team| team.seasons.any? {|season| season.id.to_s == season_id}}
    teams.min_by do |team|
      focus = team.seasons.find {|season| season.id.to_s == season_id}
      focus.regular_season_win_percentage - focus.post_season_win_percentage
    end.teamname
  end

  def winningest_coach(season_id)
    game_teams = @game_teams.select do |game|
      game.game_id.to_s[0..3] == season_id[0..3]
    end

    hash = {}
    game_teams.each do |game|
      if hash.keys.include?(game.head_coach)
        hash[game.head_coach] << game.won
      else
        hash[game.head_coach] = [game.won]
      end
    end

    hash.transform_values! do |value|
      wins = value.count {|outcome| outcome == "TRUE"}
      wins.fdiv(value.length)
    end

    hash.max_by do |key, value|
      value
    end.first
  end

  def worst_coach(season_id)
    game_teams = @game_teams.select do |game|
      game.game_id.to_s[0..3] == season_id[0..3]
    end

    hash = {}
    game_teams.each do |game|
      if hash.keys.include?(game.head_coach)
        hash[game.head_coach] << game.won
      else
        hash[game.head_coach] = [game.won]
      end
    end

    hash.transform_values! do |value|
      wins = value.count {|outcome| outcome == "TRUE"}
      wins.fdiv(value.length)
    end

    hash.min_by do |key, value|
      value
    end.first
  end

  def teams_with_season(season_id)
    @teams.select {|team| team.seasons.any? {|season| season.id.to_s == season_id}}
  end

  def most_accurate_team(season_id)
    teams_with_season(season_id).max_by do |team|
      focus = team.seasons.find {|season| season.id.to_s == season_id}
      focus.shot_accuracy
    end.teamname
  end

  def least_accurate_team(season_id)
    teams_with_season(season_id).min_by do |team|
      focus = team.seasons.find {|season| season.id.to_s == season_id}
      focus.shot_accuracy
    end.teamname
  end

  def most_hits(season_id)
      teams_with_season(season_id).max_by do |team|
        focus = team.seasons.find {|season| season.id.to_s == season_id}
        focus.number_of_hits
      end.teamname
    end

  def fewest_hits(season_id)
      teams_with_season(season_id).min_by do |team|
        focus = team.seasons.find {|season| season.id.to_s == season_id}
        focus.number_of_hits
      end.teamname
    end

    def power_play_goal_percentage(season_id)
      teams = @teams.select {|team| team.seasons.any? {|season| season.id.to_s == season_id}}
      # @teams.map(&:season)
      power_play_goals = 0
      all_goals = 0
      teams.each do |team|
        focus = team.seasons.find {|season| season.id.to_s == season_id}
        power_play_goals += focus.power_play_goals
        all_goals += focus.all_goals
      end
      power_play_goals.fdiv(all_goals).round(2)
    end
end
