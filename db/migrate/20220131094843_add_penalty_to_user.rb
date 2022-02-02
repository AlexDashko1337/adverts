class AddPenaltyToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :penalty, :integer, default: 0
    add_column :users, :banned_to, :datetime, default: nil
  end
end
