class RemoveImageFromExplanation < ActiveRecord::Migration[5.2]
  def change
    remove_column :explanations, :image, :string
  end
end
