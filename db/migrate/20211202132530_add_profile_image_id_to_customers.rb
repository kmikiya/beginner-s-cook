class AddProfileImageIdToCustomers < ActiveRecord::Migration[5.2]
  def change
    add_column :customers, :profile_image_id, :string
    add_column :customers, :bg_image_id, :string
  end
end
