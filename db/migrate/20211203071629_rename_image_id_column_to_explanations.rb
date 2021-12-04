class RenameImageIdColumnToExplanations < ActiveRecord::Migration[5.2]
  def change
    rename_column :explanations, :image_id, :process_image
  end
end
