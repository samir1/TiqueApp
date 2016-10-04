class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :fname, :null => false
      t.string :lname, :null => false
      t.string :email, :unique => true
      t.string :user_code, :unique => true
      t.string :password_digest, :null => false
      t.string :salt

      t.timestamps
    end
  end
end
