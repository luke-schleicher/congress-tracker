class CreateBills < ActiveRecord::Migration[5.0]
  def change
    create_table :bills, id: false do |t|
      t.string :bill_id, null: false
      t.string :official_title
      t.string :popular_title
      t.text :summary_short
      t.date :introduced_on
      t.date :last_vote_at
      t.text :keywords

      t.timestamps
    end
    add_index :bills, :bill_id, unique: true
  end
end
