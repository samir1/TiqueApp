class CreateCodes < ActiveRecord::Migration[5.0]
  def change
    create_table :codes do |t|
      t.integer :owner
      t.string :code_value
      t.string :title
      t.string :code_id

      t.timestamps
    end
  end
end
