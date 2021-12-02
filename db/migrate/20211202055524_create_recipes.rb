class CreateRecipes < ActiveRecord::Migration[5.2]
  def change
    create_table :recipes do |t|
      t.integer :customer_id, null: false
      t.string :title,        null: false
      t.integer :time,        null: false
      t.string :image,        null: false
      t.string :comment,      null: false

      t.timestamps
    end
  end
end
