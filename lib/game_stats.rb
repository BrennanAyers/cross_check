module GameStats

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

end
