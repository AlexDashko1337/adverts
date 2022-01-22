class AddUserRefToComments < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :comments, :users, null: false, foreign_key: true
  end
end
