class RemoveAmountFromMaterialDetails < ActiveRecord::Migration[5.2]
  def change
    remove_column :material_details, :amount, :string
  end
end
