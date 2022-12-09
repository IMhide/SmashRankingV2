class PlayersController < ApplicationController
  def show
    @player = Player.find(params[:id])
    @rankings = Ranking.order(id: :desc).all
  end
end
