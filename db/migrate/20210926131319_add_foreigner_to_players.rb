class AddForeignerToPlayers < ActiveRecord::Migration[6.1]
  def change
    add_column :players, :foreigner, :boolean, null: false, default: false
  end
end
