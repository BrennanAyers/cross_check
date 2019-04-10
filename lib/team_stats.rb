module TeamStats
  
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

end
