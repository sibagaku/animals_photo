class RenameUserIdColumnToFollows < ActiveRecord::Migration[6.1]
  def change
    rename_column :follows, :user_id, :followed_id
  end
end
