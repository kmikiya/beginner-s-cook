class RemoveImageFromRecipe < ActiveRecord::Migration[5.2]
  def change
    remove_column :recipes, :image, :string
  end
end
