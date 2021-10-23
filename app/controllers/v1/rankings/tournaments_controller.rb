module V1
  module Rankings
    class TournamentsController < ::V1::ApplicationController
      def index
        player = Player.find(params[:player_id])
        ranking = Ranking.find(params[:ranking_id])
        payload = TournamentsPayloadByPlayer.new(player: player, ranking: ranking).call
        render json: payload, include: :participations
      end
    end
  end
end
