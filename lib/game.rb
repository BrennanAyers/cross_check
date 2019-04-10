class Game
  attr_reader :id,
              :season,
              :type,
              :date_time,
              :away_team_id,
              :home_team_id,
              :away_goals,
              :home_goals,
              :outcome,
              :score,
              :team_stats,
              :total_goals

  def initialize(info)
    @id = info[:game_id]
    @season = info[:season].to_s
    @type = info[:type]
    @date_time = info[:date_time]
    @away_team_id = info[:away_team_id]
    @home_team_id = info[:home_team_id]
    @away_goals = info[:away_goals]
    @home_goals = info[:home_goals]
    @outcome = info[:outcome]
    @score = info[:away_goals] + info[:home_goals]
    @team_stats = []
  end

  def score_differential
    (@away_goals - @home_goals).abs
  end

  def add(game_team)
    @team_stats << game_team
  end

  def winners_id
    @outcome.start_with?('away') ?  @away_team_id : @home_team_id
  end

  def losers_id
    @outcome.start_with?('home') ? @away_team_id : @home_team_id
  end

  def goals_for_team(id)
    return @away_goals if id == @away_team_id
    return @home_goals if id == @home_team_id
  end

end
