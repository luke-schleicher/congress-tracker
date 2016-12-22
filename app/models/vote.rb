class Vote < ApplicationRecord

  belongs_to :legislator, foreign_key: :voter_id
  belongs_to :bill
  
end
