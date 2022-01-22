class CreateAdverts < ActiveRecord::Migration[7.0]
  def change
    create_table :adverts do |t|
      t.integer :user_id
      t.text :context

      t.timestamps
    end
  end
end
