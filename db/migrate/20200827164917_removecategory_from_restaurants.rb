class RemovecategoryFromRestaurants < ActiveRecord::Migration[5.2]
  def up
    remove_column :restaurants, :category
  end

  def down
    add_column :restaurants, :category
  end
end
