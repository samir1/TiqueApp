class ChangeCritiquesReceiverToCode < ActiveRecord::Migration[5.0]
  def change
    rename_column :critiques, :receiver_id, :code_value
    change_column :critiques, :code_value, :string
  end
end
