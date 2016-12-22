class CreateBills < ActiveRecord::Migration[5.0]
  def change
    create_table :bills do |t|

      t.integer :bill_id
      t.string :official_title
      t.string :popular_title
      t.text :summary_short
      t.date :introduced_on
      t.date :last_vote_at
      t.text :keywords

      t.timestamps
    end
  end
end
