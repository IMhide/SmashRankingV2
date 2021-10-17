module V1
  module Rankings
    class PlayerController < ::V1::ApplicationController
      def show
        @player = Player.find(params[:id])
        @ranking = Ranking.find(params[:ranking_id])

        ret = {
          ranking: {
            name: @ranking.name,
            placed_player_count: @ranking.standing.count,
            all_player_count: @ranking.tmp_standing.count
          },
          player: @player,
          match_count: {
            won: @player.matches_won.joins(:tournament).where(tournaments: {ranking: @ranking}).count,
            lost: @player.matches_lost.joins(:tournament).where(tournaments: {ranking: @ranking}).count
          }
        }

        render json: ret
      end
    end
  end
end
