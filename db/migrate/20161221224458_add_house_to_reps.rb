class AddHouseToReps < ActiveRecord::Migration[5.0]
  def change
    add_column :reps, :house, :string
  end
end
