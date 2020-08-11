class CreateFavorites < ActiveRecord::Migration[5.2]
  def change
    create_table :favorites do |t|
      t.integer :user_id
      t.integer :restaurant_id

      t.timestamps
    end
    add_index :favorites, [:user_id, :restaurant_id], unique: true
  end
end
