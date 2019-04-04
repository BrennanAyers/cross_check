class GameTeam
  attr_reader  :game_id,
               :team_id,
               :hoa,
               :won,
               :settled_in,
               :head_coach,
               :goals,
               :shots,
               :hits,
               :pim,
               :powerplayopportunities,
               :powerplaygoals,
               :faceoffwinpercentage,
               :giveaways,
               :takeaways

  def initialize(info)
    @game_id = info[:game_id]
    @team_id = info[:team_id]
    @hoa = info[:hoa]
    @won = info[:won]
    @settled_in = info[:settled_in]
    @head_coach = info[:head_coach]
    @goals = info[:goals]
    @shots = info[:shots]
    @hits = info[:hits]
    @pim = info[:pim]
    @powerplayopportunities = info[:powerplayopportunities]
    @powerplaygoals = info[:powerplaygoals]
    @faceoffwinpercentage = info[:faceoffwinpercentage]
    @giveaways = info[:giveaways]
    @takeaways = info[:takeaways]
  end

  def score_differential
    (@away_goals - @home_goals).abs
  end
end
