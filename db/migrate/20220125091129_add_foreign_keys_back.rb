class AddForeignKeysBack < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :adverts, :users, null: false, foreign_key: true
    add_foreign_key :comments, :users, null: false, foreign_key: true
    add_foreign_key :comments, :adverts, null: false, foreign_key: true
  end
end
