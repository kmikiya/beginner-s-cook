class CreateReports < ActiveRecord::Migration[5.2]
  def change
    create_table :reports do |t|
      t.integer :customer_id, null: false
      t.integer :recipe_id, null: false
      t.string :impression, null: false
      t.float :evaluation, null: false
      t.string :image_id, null: false

      t.timestamps
    end
  end
end
