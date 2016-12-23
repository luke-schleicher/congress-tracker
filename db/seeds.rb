########################
# Deleting
########################

puts "Removing records"

# Legislator.destroy_all
Bill.destroy_all
Vote.destroy_all

puts "Records removed"

VoteSmart.api_key = ENV["VOTESMART_KEY"]

########################
# Set Up
########################

def build_url(query)
  ENDPOINT + query
end


ENDPOINT = "https://congress.api.sunlightfoundation.com/"


########################
# Legislators
########################

# puts "Getting legislators..."

# NUMBER_OF_LEGISLATOR_PAGES = 0 # 27
# legislators = "legislators?fields=bioguide_id,fax,first_name,last_name,birthday,chamber,gender,oc_email,party,phone,state,term_end,term_start,website,twitter_id,facebook_id,youtube_id,votesmart_id,office&page="
# legislator_data = []

# NUMBER_OF_LEGISLATOR_PAGES.times do |page|
#   legis_page = legislators + (page + 1).to_s
#   url = build_url(legis_page)
#   response = HTTParty.get(url)
#   legislator_data << response
# end

# legislator_data.each.with_index do |page, i|
#   page["results"].each do |legislator|
#     l = Legislator.new
#     l.fax = legislator["fax"]
#     l.twitter_url = "https://twitter.com/" + legislator["twitter_id"].to_s
#     l.youtube_url = "https://youtube.com/" + legislator["youtube_id"].to_s
#     l.facebook_url = "https://facebook.com/" + legislator["facebook_id"].to_s
#     l.chamber = legislator["chamber"]
#     l.party = legislator["party"]
#     l.first_name = legislator["first_name"]
#     l.last_name = legislator["last_name"]
#     l.gender = legislator["gender"]
#     l.email = legislator["oc_email"]
#     l.website = legislator["website"]
#     l.term_start = legislator["term_start"]
#     l.term_end = legislator["term_end"]
#     l.state = legislator["state"]

#     sunset_state = legislator["state"]

#     sunset_votesmart_id = legislator["votesmart_id"].to_s

#     if sunset_votesmart_id.empty?
#       api_call = VoteSmart::Official.get_by_lastname(legislator["last_name"])

#       if api_call.to_s.include?("error")
#         sunset_votesmart_id = "N/A"
#       else
#         matching_candidates = api_call["candidateList"]["candidate"]

#         if Array === matching_candidates
#           matching_candidates.each do |candidate|
#             sunset_votesmart_id = candidate["candidateId"] if candidate["officeStateId"] == sunset_state
#           end
#         elsif Hash === matching_candidates #If only one candidate, it'll be a hash instead
#           sunset_votesmart_id =  api_call["candidateList"]["candidate"]["candidateId"]
#         end
#       end
#     end

#     l.votesmart_id = sunset_votesmart_id.to_s

#     l.phone = legislator["phone"]
#     l.office = legislator["office"]
#     l.birthday = legislator["birthday"]
#     l.bioguide_id = legislator["bioguide_id"]
#     l.save

#   end
# end

# puts "Legislators... created"


########################
# Bills
########################

NUMBER_OF_BILL_PAGES = 20 #20
bills = "bills?congress=114&fields=bill_id,official_title,popular_title,summary_short,introduced_on,sponsor_id,last_vote_at,keywords,history.enacted&order=history.enacted&per_page=50&page="
bill_data = []

NUMBER_OF_BILL_PAGES.times do |page|
  bill_page = bills + (page + 1).to_s
  url = build_url(bill_page)
  response = HTTParty.get(url)
  bill_data << response
end

puts "Getting bills..."

already_been_dun = []
bill_data.each.with_index do |page, i|
  page["results"].each do |bill|
    b = Bill.new

    b.bill_id = bill["bill_id"]

    b.official_title = bill["official_title"]
    b.popular_title = bill["popular_title"]
    b.summary_short = bill["summary_short"]
    b.introduced_on = bill["introduced_on"]
    b.last_vote_at = bill["last_vote_at"]
    b.sponsor_id = bill["sponsor_id"]
    b.keywords = bill["keywords"]
    b.enacted = bill["history"]["enacted"]
    b.save unless already_been_dun.include?(bill["bill_id"])
    already_been_dun << bill["bill_id"]
  end
  puts "Compiled bill data from page #{i} of Sunlight's database."
end

puts "Finished adding bills to database"

########################
# Votes
########################


NUMBER_OF_VOTE_PAGES = 92 # 92

votes = "votes?congress=114&fields=voter_ids,bill_id,voted_at&page="
vote_data = []

NUMBER_OF_VOTE_PAGES.times do |page|
  vote_page = votes + (page + 1).to_s
  url = build_url(vote_page)
  response = HTTParty.get(url)
  vote_data << response
end

puts "Getting votes..."

vote_data.each.with_index do |page, i|
  page["results"].each do |vote|

    vote["voter_ids"].each do |voter, type|
      v = Vote.new
      v.bill_id = vote["bill_id"]
      v.voted_at = vote["voted_at"]
      v.voter_id = voter
      v.vote_type = type
      v.save 

    end
  end
  puts "Compiled vote data from page #{i} of Sunlight's database."
end

puts "Finished compiling vote data"
