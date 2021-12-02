class CreateMaterialDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :material_details do |t|
      t.string :name, null: false
      t.integer :calorie
      t.integer :sugar
      t.integer :protein
      t.integer :lipids
      t.integer :dietary_fiber
      t.integer :salt

      t.timestamps
    end
  end
end
