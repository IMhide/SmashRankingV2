class CreateMatches < ActiveRecord::Migration[6.1]
  def change
    create_table :matches do |t|
      t.references :winner, null: false, foreign_key: { to_table: :players }
      t.references :looser, null: false, foreign_key: { to_table: :players }
      t.references :tournament, null: false, foreign_key: true
      t.integer :winner_score
      t.integer :looser_score
      t.datetime :completed_at

      t.timestamps
    end
  end
end
