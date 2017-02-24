class AddColumnToCodes < ActiveRecord::Migration[5.0]
  def change
  	add_column :codes, :ta_emails, :string
  end
end
