module Players
  class RankingsController < ApplicationController
    def index
      @ranking = Ranking.last
      @query = params[:query]
      @page = params[:page]
    end

    def show
      @ranking = Ranking.find(params[:id])
      @player = Player.find(params[:player_id])
      @match_win = Match.where(winner_id: @player.id, tournament_id: @ranking.tournament_ids)
      @match_lost = Match.where(looser_id: @player.id, tournament_id: @ranking.tournament_ids)

      @placement = "#{@ranking.placement_for(player_id: @player.id)&.position} / #{@ranking.participant_count}"
      @match_win_count = @match_win.count
      @match_lost_count = @match_lost.count
      @set_win = @match_win.reduce(0) { |r, m| r + m.winner_score }
      @set_lost = @match_lost.reduce(0) { |r, m| r + m.looser_score }
    end
  end
end
