class RenameCommentDetailIdColumnToComments < ActiveRecord::Migration[5.2]
  def change
    rename_column :comments, :comment_detail_id, :customer_id
  end
end
