class RemovePeopleFromMaterials < ActiveRecord::Migration[5.2]
  def change
    remove_column :materials, :people, :integer
  end
end
