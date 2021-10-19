module V1
  module Rankings
    class TournamentsController < ::V1::ApplicationController
      def index
        player = Player.find(params[:player_id])
        payload = player.tournaments.includes(:participations)
          .where(ranking_id: params[:ranking_id]).order(dated_at: :desc)
        render json: payload, includes: :participations
      end
    end
  end
end
