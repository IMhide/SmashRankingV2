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
            all_player_count: @ranking.tmp_standing.count,
            standing: @ranking.standing,
            tmp_standing: @ranking.tmp_standing
          },
          player_standing: {
            standing: get_player_standing,
            match_count: {
              won: @player.matches_won.joins(:tournament).where(tournaments: {ranking: @ranking}).count,
              lost: @player.matches_lost.joins(:tournament).where(tournaments: {ranking: @ranking}).count
            }
          }
        }

        render json: ret
      end

      private

      def get_player_standing
        @ranking.standing.find { |player| player['id'] == @player.id } ||
          @ranking.tmp_standing.find { |player| player['id'] == @player.id }
      end
    end
  end
end
