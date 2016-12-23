class Legislator < ApplicationRecord

  self.primary_key = 'bioguide_id'

  has_many :votes, foreign_key: :voter_id
  has_many :bills, through: :votes
  has_many :sponsored_bills, foreign_key: :sponsor_id, class_name: 'Bill'
  has_many :legislator_users, foreign_key: :bioguide_id
  has_many :users, through: :legislator_users

  def photo_url
    "http://d229l5sflpl9cp.cloudfront.net/canphoto/#{self.votesmart_id}.jpg"
  end

  def bioguide_id
    bioguide_id
  end

  def to_param
    bioguide_id.parameterize
  end

  def five_recent_votes
    votes.where(voted_at: (Time.now.midnight - 14.day)..Time.now.midnight).limit(5)
  end


  def get_top_contributors(crpId)
    url = "https://www.opensecrets.org/api/?method=candContrib&cid=#{crpId}&cycle=2016&output=json&apikey=#{OPEN_SECRETS_KEY}"
    response = HTTParty.get(url)
    JSON.parse(response)["response"]["contributors"]["contributor"]
  end

  def top_contributors

  end

    helper :top_contributors
  end




end
