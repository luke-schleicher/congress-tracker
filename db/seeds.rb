puts "clearing database...."

Bill.destroy_all
Legislator.destroy_all

puts "Database cleared...."


VoteSmart.api_key = ENV["secret_key"]




def build_url(query)
  ENDPOINT + query
end


ENDPOINT = "https://congress.api.sunlightfoundation.com/"

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
    l.website = legislator["website"]
    l.term_start = legislator["term_start"]
    l.term_end = legislator["term_end"]
    l.state = legislator["state"]

    sunset_state = legislator["state"]

    sunset_votesmart_id = legislator["votesmart_id"].to_s

    if sunset_votesmart_id.empty?
      api_call = VoteSmart::Official.get_by_lastname(legislator["last_name"])

      if api_call.to_s.include?("error")
        sunset_votesmart_id = "N/A"
      else
        matching_candidates = api_call["candidateList"]["candidate"]

        if Array === matching_candidates
          matching_candidates.each do |candidate|
            sunset_votesmart_id = candidate["candidateId"] if candidate["officeStateId"] == sunset_state
          end
        elsif Hash === matching_candidates #If only one candidate, it'll be a hash instead
          sunset_votesmart_id =  api_call["candidateList"]["candidate"]["candidateId"]
        end
      end
    end

    l.votesmart_id = sunset_votesmart_id.to_s



    l.phone = legislator["phone"]
    l.office = legislator["office"]
    l.birthday = legislator["birthday"]
    l.bioguide_id = legislator["bioguide_id"]
    l.save

    puts $fuck if l.votesmart_id.nil?
end

puts "Legislators... created"





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
end
