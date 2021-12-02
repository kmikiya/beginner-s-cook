class CreateMaterials < ActiveRecord::Migration[5.2]
  def change
    create_table :materials do |t|
      t.integer :recipe_id
      t.integer :material_detail_id

      t.timestamps
    end
  end
end
