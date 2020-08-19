class AddCityAddressToRestaurants < ActiveRecord::Migration[5.2]
  def change
  	add_column :restaurants, :city_address, :string
  end
end
