# frozen_string_literal: true

class WinrateComponent < BaseComponent
  def initialize(win_count:, lost_count:)
    @win_count = win_count
    @lost_count = lost_count
  end

  def value
    (@win_count / (@win_count + @lost_count.to_f)) * 100
  end
end
