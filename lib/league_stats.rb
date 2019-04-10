module LeagueStats
  
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

end
