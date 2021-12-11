class ChangeDataAmountToMaterialDetails < ActiveRecord::Migration[5.2]
  def change
    change_column :material_details, :amount, :string
  end
end
