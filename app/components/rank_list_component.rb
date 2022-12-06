# frozen_string_literal: true

class RankListComponent < BaseComponent
  def initialize(ranking:, query: nil)
    @ranking = ranking
    @query = query
  end

  def displayed_standing
    if @query.nil?
      @ranking.standing
    elsif params[:query]
      @ranking.standing.select { |rank| rank['name'].downcase.include?(@query.downcase) }
    end
  end

  def bg_color(i)
    i.odd? ? 'bg-secondary bg-opacity-25' : ''
  end
end
