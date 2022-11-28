class RankingController < ApplicationController
  include Pagy::Backend
  def index
    @ranking = Ranking.last.standing
    @ranking = @ranking.select { |rank| rank['name'].downcase.include?(params[:query].downcase) } if params[:query]
  end
end
