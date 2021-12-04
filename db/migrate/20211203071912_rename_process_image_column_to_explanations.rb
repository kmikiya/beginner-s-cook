class RenameProcessImageColumnToExplanations < ActiveRecord::Migration[5.2]
  def change
    rename_column :explanations, :process_image, :process_image_id
  end
end
