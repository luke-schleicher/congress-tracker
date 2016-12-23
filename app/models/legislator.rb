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

  def request_contributions
    crpId = self.crf_id
    api_key = ENV["OPEN_SECRETS_KEY"]
    url = "https://www.opensecrets.org/api/?method=candContrib&cid=#{crpId}&cycle=2016&output=json&apikey=#{api_key}"
    response = HTTParty.get(url)
    JSON.parse(response)["response"]["contributors"]["contributor"]
  end

  def top_contributions
    top_three = {}
    all_contributions = request_contributions
    # binding.pry
    3.times do |i|
      contribution = all_contributions[i].first.last
      org = contribution["org_name"]
      amount = contribution["total"].to_s
      top_three[i] = [org, amount]
    end
    top_three
  end

  # helper :top_contributions

  # {0=>["Eye of the Tiger PAC", "10000"], 1=>["Majority Cmte PAC", "10000"], 2=>["New Cuba PAC", "10000"]}



end
