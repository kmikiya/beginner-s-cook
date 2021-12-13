class AddMemoToLists < ActiveRecord::Migration[5.2]
  def change
    add_column :lists, :memo, :string
  end
end
