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



end
