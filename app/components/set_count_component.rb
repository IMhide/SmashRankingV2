# frozen_string_literal: true

class SetCountComponent < BaseComponent
  def initialize(match_win:, match_lost:)
    @set_win = match_win.reduce(0) { |r, m| r + m.winner_score }
    @set_lost = match_lost.reduce(0) { |r, m| r + m.looser_score }
  end

  def value
    "W #{@set_win} - #{@set_lost} L"
  end
end
