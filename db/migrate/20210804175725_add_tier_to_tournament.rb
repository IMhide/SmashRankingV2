class AddTierToTournament < ActiveRecord::Migration[6.1]
  def change
    add_column :tournaments, :tier, :string
  end
end
