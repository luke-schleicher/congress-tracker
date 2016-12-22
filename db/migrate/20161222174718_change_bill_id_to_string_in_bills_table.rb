class ChangeBillIdToStringInBillsTable < ActiveRecord::Migration[5.0]
  def change
    remove_column :bills, :bill_id
    add_column :bills, :bill_id, :string
  end
end
