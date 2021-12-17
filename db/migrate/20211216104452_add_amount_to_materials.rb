class AddAmountToMaterials < ActiveRecord::Migration[5.2]
  def change
    add_column :materials, :amount, :string
  end
end
