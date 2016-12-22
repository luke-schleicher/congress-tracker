class RemovePhotoUrlFromLegislator < ActiveRecord::Migration[5.0]
  def change
    remove_column :legislators, :photo_url
  end
end
