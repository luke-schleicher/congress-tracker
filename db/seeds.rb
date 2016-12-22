# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# read from current legislators file and populate database with it

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
