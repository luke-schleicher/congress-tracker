class Legislator < ApplicationRecord

  self.primary_key = 'bioguide_id'

  has_many :votes, foreign_key: :voter_id
  has_many :bills, through: :votes

  def photo_url
    "http://d229l5sflpl9cp.cloudfront.net/canphoto/#{self.votesmart_id}.jpg"
  end

  def to_param
    bioguide_id.parameterize
  end

end
