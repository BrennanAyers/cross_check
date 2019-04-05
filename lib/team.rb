class Team
  attr_reader :id,
              :franchiseid,
              :shortname,
              :teamname,
              :abbreviation,
              :link,
              :games
  def initialize(info)
    @id = info[:team_id]
    @franchiseid = info[:franchiseid]
    @shortname = info[:shortname]
    @teamname = info[:teamname]
    @abbreviation = info[:abbreviation]
    @link = info[:link]
    @games = []
  end

  def add(game)
    @games << game
  end
  ##NO TESTS##
  def our_stats_in_game(game)
    game.team_stats.find{|stats| stats.team_id == @id}
  end

  def rival_stats_in_game(game)
    game.team_stats.find{|stats| stats.team_id != @id}
  end




end
