class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :country
      t.string :sex
      t.string :check_in

      t.timestamps
    end
  end
end
