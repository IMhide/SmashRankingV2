# frozen_string_literal: true

class RankListComponent < BaseComponent
  def initialize(ranking:)
    @ranking = ranking
  end

  def bg_color(i)
    i.odd? ? 'bg-secondary bg-opacity-25' : ''
  end
end
