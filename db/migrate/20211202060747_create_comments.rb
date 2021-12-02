class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.integer :comment_detail_id, null: false
      t.integer :explanation_id, null: false

      t.timestamps
    end
  end
end
