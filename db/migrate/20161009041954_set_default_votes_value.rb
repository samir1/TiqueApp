class SetDefaultVotesValue < ActiveRecord::Migration[5.0]
  def change
    change_column_default(:critiques, :votes, 0)
  end
end
