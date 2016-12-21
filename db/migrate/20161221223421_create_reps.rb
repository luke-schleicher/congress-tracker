class CreateReps < ActiveRecord::Migration[5.0]
  def change
    create_table :reps do |t|
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
      t.string :facebook_url
      t.string :twitter_url
      t.string :youtube_url
      t.string :fax
      t.string :contact_form_url
      t.string :photo_url

      t.timestamps
    end
  end
end
