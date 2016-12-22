class CreateLegislators < ActiveRecord::Migration[5.0]
  def change
    create_table :legislators do |t|
      t.string :first_name
      t.string :last_name
      t.string :party
      t.string :state
      t.string :chamber
      t.date :term_start
      t.date :term_end
      t.string :phone
      t.string :email
      t.string :website
      t.string :contact_form_url
      t.string :facebook_url
      t.string :twitter_url
      t.string :youtube_url
      t.string :fax
      t.string :photo_url
      t.string :gender
      t.string :votesmart_id
      t.string :office
      t.date :birthday
      t.string :bioguide_id

      t.timestamps
    end
  end
end
