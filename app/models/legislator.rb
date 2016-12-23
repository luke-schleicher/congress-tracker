class Legislator < ApplicationRecord

  self.primary_key = 'bioguide_id'

  has_many :votes, foreign_key: :voter_id
  has_many :bills, through: :votes
  has_many :sponsored_bills, foreign_key: :sponsor_id, class_name: 'Bill'

  def photo_url
    "http://d229l5sflpl9cp.cloudfront.net/canphoto/#{self.votesmart_id}.jpg"
  end

  def bioguide_id
    bioguide_id
  end

  def to_param
    bioguide_id.parameterize
  end

end
