class AddSyncVariablesToTournament < ActiveRecord::Migration[6.1]
  def change
    add_column :tournaments, :match_sync, :string
  end
end
