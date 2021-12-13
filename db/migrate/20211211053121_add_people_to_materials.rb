class AddPeopleToMaterials < ActiveRecord::Migration[5.2]
  def change
    add_column :materials, :people, :integer
  end
end
