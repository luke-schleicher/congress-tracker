class AddCrfIdToLegislators < ActiveRecord::Migration[5.0]
  def change
    add_column :legislators, :crf_id, :string
  end
end
