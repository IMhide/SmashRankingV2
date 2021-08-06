class AddStandingsToRanking < ActiveRecord::Migration[6.1]
  def change
    add_column :rankings, :standing, :jsonb
  end
end
