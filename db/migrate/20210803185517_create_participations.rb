class CreateParticipations < ActiveRecord::Migration[6.1]
  def change
    create_table :participations do |t|
      t.references :tournament, foreign_key: true
      t.references :player, foreign_key: true
      t.integer :placement, null: false
      t.integer :seed, null: false
      t.boolean :verified

      t.timestamps
    end
  end
end
