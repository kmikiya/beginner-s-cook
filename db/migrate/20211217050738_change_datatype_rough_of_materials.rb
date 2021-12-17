class ChangeDatatypeRoughOfMaterials < ActiveRecord::Migration[5.2]
  def change
    change_column :materials, :rough, :float
  end
end
