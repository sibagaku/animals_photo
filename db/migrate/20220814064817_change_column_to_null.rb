class ChangeColumnToNull < ActiveRecord::Migration[6.1]
  def change
    change_column_null :users, :self_introduction, true
  end
end
