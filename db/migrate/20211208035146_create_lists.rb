class CreateLists < ActiveRecord::Migration[5.2]
  def change
    create_table :lists do |t|
      t.integer :customer_id
      t.integer :recipe_id

      t.timestamps
    end
  end
end
