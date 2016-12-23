class AddSponsorToBillTable < ActiveRecord::Migration[5.0]
  def change
    add_column :bills, :sponsor_id, :string
  end
end
