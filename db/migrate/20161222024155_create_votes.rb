class CreateVotes < ActiveRecord::Migration[5.0]
  def change
    create_table :votes do |t|

      t.string :voter_id
      t.string :bill_id
      t.string :vote_type

      t.timestamps
    end
    add_index :votes, [:voter_id, :bill_id]
  end
end
