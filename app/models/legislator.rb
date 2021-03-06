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
    my_bills = bills.where(last_vote_at: (Time.now.midnight - 14.day)..Time.now.midnight).distinct.limit(5)
    my_bills.map { |bill| bill.votes.where(voter_id: id).where.not(vote_type: "Not Voting").order(:voted_at).first }
  end

  def name
    first_name + " " + last_name
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
    3.times do |i|
      contribution = all_contributions[i].first.last
      org = contribution["org_name"]
      amount = contribution["total"].to_s
      top_three[i] = [org, amount]
    end
    top_three
  end

end
