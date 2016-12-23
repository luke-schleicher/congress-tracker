class RemovePopularTitleAndSummaryFromBill < ActiveRecord::Migration[5.0]
  def change
    remove_column :bills, :popular_title
    remove_column :bills, :summary_short
  end
end
