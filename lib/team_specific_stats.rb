module TeamSpecificStats

  def our_stats_in_game(game)
    game.team_stats.find{|stats| stats.team_id == @id}
  end

  def rival_stats_in_game(game)
    game.team_stats.find{|stats| stats.team_id != @id}
  end

end
