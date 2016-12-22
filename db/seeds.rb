
########################
# Deleting
########################

puts "Removing records"

Legislator.destroy_all
Bill.destroy_all
Vote.destroy_all

puts "Records removed"


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

NUMBER_OF_LEGISLATOR_PAGES = 27
legislators = "legislators?page="
legislator_data = []

NUMBER_OF_LEGISLATOR_PAGES.times do |page|
  legis_page = legislators + (page + 1).to_s
  url = build_url(legis_page)
  response = HTTParty.get(url)
  legislator_data << response
end


puts "Getting legislators..."

legislator_data.each.with_index do |page, i|
  page["results"].each do |legislator|
    l = Legislator.new
    l.chamber = legislator["chamber"]
    l.party = legislator["party"]
    l.first_name = legislator["first_name"]
    l.last_name = legislator["last_name"]
    l.gender = legislator["gender"]
    l.email = legislator["oc_email"]
    l.votesmart_id = legislator["votesmart_id"]
    l.website = legislator["website"]
    l.term_start = legislator["term_start"]
    l.term_end = legislator["term_end"]
    l.state = legislator["state"]
    l.phone = legislator["phone"]
    l.office = legislator["office"]
    l.birthday = legislator["birthday"]
    l.bioguide_id = legislator["bioguide_id"]
    l.save
  end
  puts "Compiled legislator data from page #{i} of Sunlight's database."
end

puts "Finished adding legislators to database"

########################
# Bills
########################

NUMBER_OF_BILL_PAGES = 13
bills = "bills?congress=114&history.enacted=true&page="
bill_data = []

NUMBER_OF_BILL_PAGES.times do |page|
  bill_page = bills + (page + 1).to_s
  url = build_url(bill_page)
  response = HTTParty.get(url)
  bill_data << response
end

puts "Getting bills..."

bill_data.each.with_index do |page, i|
  page["results"].each do |bill|
    b = Bill.new
    b.bill_id = bill["bill_id"]
    b.official_title = bill["official_title"]
    b.popular_title = bill["popular_title"]
    b.summary_short = bill["summary_short"]
    b.introduced_on = bill["introduced_on"]
    b.last_vote_at = bill["last_vote_at"]
    b.keywords = bill["keywords"]
    b.save
  end
  puts "Compiled bill data from page #{i} of Sunlight's database."
end

puts "Finished adding bills to database"

########################
# Votes
########################

NUMBER_OF_VOTE_PAGES = 92
votes = "votes?congress=114&fields=voter_ids,bill_id&page="
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
    bill_id = vote["bill_id"]
    vote["voter_ids"].each do |voter, type|
      v = Vote.new
      v.bill_id = bill_id
      v.voter_id = voter
      v.vote_type = type
      v.save
    end
  end
  puts "Compiled vote data from page #{i} of Sunlight's database."
end

puts "Finished compiling vote data"


