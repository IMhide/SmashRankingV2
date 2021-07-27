class CreateTournaments < ActiveRecord::Migration[6.1]
  def change
    create_table :tournaments do |t|
      t.string :name, null: false
      t.string :slug, null: false
      t.string :tournament_remote_id
      t.string :event_remote_id
      t.integer :remote_participant_count
      t.datetime :dated_at

      t.timestamps
    end
  end
end
