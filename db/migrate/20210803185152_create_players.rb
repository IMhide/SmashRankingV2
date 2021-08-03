class CreatePlayers < ActiveRecord::Migration[6.1]
  def change
    create_table :players do |t|
      t.string :name, null: false
      t.string :team
      t.string :remote_id, null: false

      t.timestamps
    end
  end
end
