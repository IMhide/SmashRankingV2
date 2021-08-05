class AddRatingStateToRanking < ActiveRecord::Migration[6.1]
  def change
    add_column :rankings, :compute_state, :string
  end
end
