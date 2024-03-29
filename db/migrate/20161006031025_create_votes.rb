class CreateVotes < ActiveRecord::Migration[5.0]
  def change
    create_table :votes do |t|
      t.integer :voter_id, :null => false
      t.integer :critique_id, :null => false
      t.boolean :upvote, :null => false

      t.timestamps
    end
  end
end
