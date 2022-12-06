class RankingController < ApplicationController
  def index
    @ranking = Ranking.last
    @query = params[:query]
  end
end
