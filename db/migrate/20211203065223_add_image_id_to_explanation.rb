class AddImageIdToExplanation < ActiveRecord::Migration[5.2]
  def change
    add_column :explanations, :image_id, :string
  end
end
