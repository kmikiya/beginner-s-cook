class RemoveProfileImageFromCustomers < ActiveRecord::Migration[5.2]
  def change
    remove_column :customers, :profile_image, :string
    remove_column :customers, :bg_image, :string
  end
end
