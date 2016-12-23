class AddVoteTime < ActiveRecord::Migration[5.0]
  def change
    add_column :votes, :voted_at, :date
  end
end
