class AddRoughToMaterials < ActiveRecord::Migration[5.2]
  def change
    add_column :materials, :rough, :integer
  end
end
