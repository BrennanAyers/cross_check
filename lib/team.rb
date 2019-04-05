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

  def number_of_home_games
    @games.count{|game| game.home_team_id == @id}
  end

  def number_of_away_games
    @games.count{|game| game.away_team_id == @id}
  end

  def home_win_percentage
    @games.count do |game|
      our_stats_in_game(game).hoa == "home" && our_stats_in_game(game).won == true
    end.fdiv(number_of_home_games)
  end

  def away_win_percentage
    @games.count do |game|
      our_stats_in_game(game).hoa == "away" && our_stats_in_game(game).won == true
    end.fdiv(number_of_away_games)
  end

end
