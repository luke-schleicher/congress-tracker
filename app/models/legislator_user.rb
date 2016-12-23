class LegislatorUser < ApplicationRecord

  belongs_to :user
  belongs_to :legislator, foreign_key: :bioguide_id

end
