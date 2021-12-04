class AddAmountToMaterialDetails < ActiveRecord::Migration[5.2]
  def change
    add_column :material_details, :amount, :integer
  end
end
