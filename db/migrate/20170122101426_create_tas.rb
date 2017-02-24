class CreateTas < ActiveRecord::Migration[5.0]
  def change
    create_table :tas do |t|
      t.integer :user_id, :null => false
      t.string :code_value, :null => false
      t.string :email

      t.timestamps
    end
  end
end
