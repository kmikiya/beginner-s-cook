class CommentDetails < ActiveRecord::Migration[5.2]
  def change
    drop_table :comment_details
  end
end
