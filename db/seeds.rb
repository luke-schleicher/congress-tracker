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

legislator_data[0]["results"]

legislator_data.each do |page|


end






