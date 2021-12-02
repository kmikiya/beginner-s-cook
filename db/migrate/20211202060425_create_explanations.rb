class CreateExplanations < ActiveRecord::Migration[5.2]
  def change
    create_table :explanations do |t|
      t.integer :recipe_id, null: false
      t.text :explanation,  null: false
      t.string :image,      null: false

      t.timestamps
    end
  end
end
