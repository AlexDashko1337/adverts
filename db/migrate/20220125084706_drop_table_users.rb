class DropTableUsers < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :comments, :adverts
  end
end
