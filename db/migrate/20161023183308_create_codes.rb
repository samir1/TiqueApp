class CreateCodes < ActiveRecord::Migration[5.0]
  def change
    create_table :codes do |t|
      t.integer :owner, :null => false
      t.string :code_value, :null => false
      t.string :title, :null => false
      t.string :code_id, :null => false

      t.timestamps
    end
  end
end
