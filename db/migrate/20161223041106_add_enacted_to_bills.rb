class AddEnactedToBills < ActiveRecord::Migration[5.0]
  def change
    add_column :bills, :enacted, :boolean
  end
end
