class RankingController < ApplicationController
  def index
    @ranking = Ranking.last.standing
    @ranking = @ranking.select { |rank| rank['name'].downcase.include?(params[:query].downcase) } if params[:query]
  end
end
