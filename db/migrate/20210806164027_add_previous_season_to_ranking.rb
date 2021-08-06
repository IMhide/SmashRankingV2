class AddPreviousSeasonToRanking < ActiveRecord::Migration[6.1]
  def change
    add_reference :rankings, :previous_season, foreign_key: {to_table: :rankings}
  end
end
