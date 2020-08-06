class CreateRestaurants < ActiveRecord::Migration[5.2]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.text :description
      t.string :category
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :restaurants, [:user_id, :created_at]
  end
end
