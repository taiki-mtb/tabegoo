class CreateBoardComments < ActiveRecord::Migration[5.2]
  def change
    create_table :board_comments do |t|
      t.references :board, foreign_key: true
      t.references :user, foreign_key: true
      t.text :content

      t.timestamps
    end
  end
end
