# frozen_string_literal: true

class RankListComponent < BaseComponent
  PAGE_SIZE = 50

  def initialize(ranking:, query: nil, page: 1)
    @ranking = ranking
    @query = query
    @page = page.to_i || 1
  end

  def displayed_standing
    standing = if @query.nil?
      @ranking.standing
    elsif @query
      @ranking.standing.select { |rank| rank['name'].downcase.include?(@query.downcase) }
    end
    pagination(standing)
  end

  def bg_color(i)
    i.odd? ? 'bg-secondary bg-opacity-25' : ''
  end

  private

  def pagination(standing)
    first = (@page - 1) * PAGE_SIZE
    last = @page * PAGE_SIZE - 1

    if standing.count > PAGE_SIZE && (first < standing.count)
      standing[first..last]
    else
      standing[0..PAGE_SIZE]
    end
  end
end
