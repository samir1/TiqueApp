class RemoveUserCode < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :user_code
  end
end