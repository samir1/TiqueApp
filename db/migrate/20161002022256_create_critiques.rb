class CreateCritiques < ActiveRecord::Migration[5.0]
  def change
    create_table :critiques do |t|
      t.string :comment, :null => false
      t.integer :votes, :null => false, :default => 0
      t.integer :author_id, foreign_key: true
      t.integer :receiver_id, foreign_key: true
      t.boolean :positive, :null => false, :default => true

      t.timestamps
    end
  end
end
