class AddTemporaryStadingToRankings < ActiveRecord::Migration[6.1]
  def change
    add_column :rankings, :tmp_standing, :jsonb
  end
end
