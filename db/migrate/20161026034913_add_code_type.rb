class AddCodeType < ActiveRecord::Migration[5.0]
  def change
    add_column :codes, :code_type, :string, :null => false, :default => 'class'
  end
end
