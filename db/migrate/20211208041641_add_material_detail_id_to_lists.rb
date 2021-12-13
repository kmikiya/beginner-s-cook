class AddMaterialDetailIdToLists < ActiveRecord::Migration[5.2]
  def change
    add_column :lists, :material_detail_id, :integer
  end
end
