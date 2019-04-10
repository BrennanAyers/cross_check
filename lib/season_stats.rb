module SeasonStats

  def generate_teams(teams_table)
    @teams = teams_table.map{|team_info| Team.new(team_info)}
    @teams.each do |team|
      @games.each{|game|team.add(game) if game.away_team_id == team.id || game.home_team_id == team.id}
      team.generate_seasons
    end
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
    power_play_goals = 0
    all_goals = 0
    teams_with_season(season_id).each do |team|
      focus = team.seasons.find {|season| season.id.to_s == season_id}
      power_play_goals += focus.power_play_goals
      all_goals += focus.all_goals
    end
    power_play_goals.fdiv(all_goals).round(2)
  end

end
