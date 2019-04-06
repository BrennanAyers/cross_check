module TeamSpecificStats

  def our_stats_in_game(game, team_id)
    game.team_stats.find{|stats| stats.team_id == team_id}
  end

  def rival_stats_in_game(game, team_id)
    game.team_stats.find{|stats| stats.team_id != team_id}
  end

end
