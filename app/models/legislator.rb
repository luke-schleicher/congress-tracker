class Legislator < ApplicationRecord

  def photo_url
    "http://d229l5sflpl9cp.cloudfront.net/canphoto/#{self.votesmart_id}.jpg"
  end

end
