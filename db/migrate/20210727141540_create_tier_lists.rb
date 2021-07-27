class CreateTierLists < ActiveRecord::Migration[6.1]
  def change
    create_table :tier_lists do |t|
      t.integer :ss_min, null: false
      t.float :ss_coef, null: false
      t.integer :s_min, null: false
      t.float :s_coef, null: false
      t.integer :a_min, null: false
      t.float :a_coef, null: false
      t.integer :b_min, null: false
      t.float :b_coef, null: false
      t.integer :c_min, null: false
      t.float :c_coef, null: false
      t.references :rankings, foreign_key: true

      t.timestamps
    end
  end
end
