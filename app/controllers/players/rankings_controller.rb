module Players
  class RankingsController < ApplicationController
    def index
      @ranking = Ranking.last
      @query = params[:query]
      @page = params[:page]

      ### Pour les placement mettre la moyenne des placements
      ### et tu fais moyenne.floor pour avoir un int et pas un float
    end

    def show
      @ranking = Ranking.find(params[:id])
      @player = Player.find(params[:player_id])
      @match_win = Match.where(winner_id: @player.id, tournament_id: @ranking.tournament_ids)
      @match_lost = Match.where(looser_id: @player.id, tournament_id: @ranking.tournament_ids)
      @placement = @ranking.placement_for(player_id: @player.id)
    end
  end
end
