module V1
  class RankingsController < ApplicationController
    def index
      render json: Ranking.includes(:tournaments).all.order(id: :desc), include: :tournaments
    end

    def show
      render json: Ranking.find(params[:id])
    end
  end
end
