class AddApprovedColumnToAdverts < ActiveRecord::Migration[7.0]
  def change
    add_column :adverts, :approved, :boolean, default: false
  end
end
