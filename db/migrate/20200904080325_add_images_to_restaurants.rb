class AddImagesToRestaurants < ActiveRecord::Migration[5.2]
  def change
    add_column :restaurants, :images, :json
  end
end
