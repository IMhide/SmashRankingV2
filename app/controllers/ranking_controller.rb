class RankingController < ApplicationController
  def index
    @ranking = Ranking.last
    @query = params[:query]
    @page = params[:page]
  end
end
