class ChangeColumnToRestaurants < ActiveRecord::Migration[5.2]
  def up
    change_column :restaurants, :latitude, :double
    change_column :restaurants, :longitude, :double
  end

  def down
    change_column :restaurants, :latitude, :float
    change_column :restaurants, :longitude, :float
  end
end
