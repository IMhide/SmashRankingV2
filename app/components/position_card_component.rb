# frozen_string_literal: true

class PositionCardComponent < BaseComponent
  def initialize(placement:, ranking:)
    @ranking = ranking
    @placement = placement
  end

  def position_text
    text = 'Placement'
    text += ' hypothétique' if @placement.tmp
    text
  end

  def position_value
    "#{@placement.position}/#{@ranking.participant_count(tmp: @placement.tmp)}"
  end
end
