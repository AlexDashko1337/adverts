class AddUserRefToAdverts < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :adverts, :users, null: false, foreign_key: true
  end
end
