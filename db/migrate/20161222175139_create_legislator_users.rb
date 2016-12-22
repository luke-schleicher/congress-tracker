class CreateLegislatorUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :legislator_users do |t|

      t.integer :user_id
      t.string :bioguide_id

      t.timestamps
    end
  end
end
