class AddPeopleToRecipes < ActiveRecord::Migration[5.2]
  def change
    add_column :recipes, :people, :integer
  end
end
