# frozen_string_literal: true

class RankListComponent < BaseComponent
  PAGE_SIZE = 50

  def initialize(ranking:, query: nil, page: 1)
    @ranking = ranking
    @query = query
    @page = (page || 1).to_i
  end

  def displayed_standing
    pagination(queried_standing)
  end

  def bg_color(i)
    i.odd? ? 'bg-secondary bg-opacity-25' : ''
  end

  def next_link
    helpers.link_to 'Next >>', helpers.url_for(page: @page + 1), class: 'text-light' if has_next_page?
  end

  def previous_link
    helpers.link_to '<< Prev', helpers.url_for(page: @page - 1), class: 'text-light' if has_previous_page?
  end

  private

  def has_next_page?
    @page * PAGE_SIZE < queried_standing.count
  end

  def has_previous_page?
    @page > 1
  end

  def queried_standing
    if @query.nil?
      @ranking.standing
    elsif @query
      @ranking.standing.select { |rank| rank['name'].downcase.include?(@query.downcase) }
    end
  end

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
