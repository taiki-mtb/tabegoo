class DropTable < ActiveRecord::Migration[5.2]
  def change
  	drop_table :restaurant_category_relations
  end
end
