class CreateRatings < ActiveRecord::Migration[6.1]
  def change
    create_table :ratings do |t|
      t.references :match, null: false, foreign_key: true
      t.references :ranking, null: false, foreign_key: true
      t.references :player, null: false, foreign_key: true
      t.boolean :base, null: false, default: false
      t.decimal :mean, null: false, precision: 6, scale: 4
      t.decimal :deviation, null: false, precision: 6, scale: 4

      t.timestamps
    end
  end
end
