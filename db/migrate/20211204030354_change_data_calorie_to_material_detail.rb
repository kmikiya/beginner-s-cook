class ChangeDataCalorieToMaterialDetail < ActiveRecord::Migration[5.2]
  def change
    change_column :material_details, :calorie, :float
    change_column :material_details, :sugar, :float
    change_column :material_details, :protein, :float
    change_column :material_details, :lipids, :float
    change_column :material_details, :dietary_fiber, :float
    change_column :material_details, :salt, :float
  end
end
