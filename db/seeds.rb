# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# read from current legislators file and populate database with it

puts "Destroying all reps"
Rep.destroy_all

puts "Creating some House reps"
Rep.create(first_name: "Louis", last_name: "Gohmert", party: "R", state: "TX", house: "House", photo_url:"https://upload.wikimedia.org/wikipedia/comm
ons/thumb/2/2d/Louie_Gohmert_official_congressional_photo.jpg/200px-Louie_Gohmert_official_congressional_photo.jpg")
Rep.create(first_name: "Ted", last_name: "Poe", party: "R", state: "TX", house: "House", photo_url: "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3a/Ted_Poe_Official.jpg/200px-Ted_Poe_Official.jpg")
Rep.create(first_name: "Al", last_name: "Green", party: "D", state: "TX", house: "House", photo_url: "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d1/Al_Green_Official.jpg/200px-Al_Green_Official.jpg")

puts "Creating some Senators"
Rep.create(first_name: "John", last_name: "Cornyn", party: "R", state: "TX", house: "Senate", photo_url: "https://upload.wikimedia.org/wikipedia/commons/thumb/3/39/John_Cornyn_official_portrait%2C_2009.jpg/200px-John_Cornyn_official_portrait%2C_2009.jpg")
Rep.create(first_name: "Ted", last_name: "Cruz", party: "R", state: "TX", house: "Senate", photo_url: "https://upload.wikimedia.org/wikipedia/commons/thumb/8/87/Ted_Cruz%2C_official_portrait%2C_113th_Congress.jpg/200px-Ted_Cruz%2C_official_portrait%2C_113th_Congress.jpg")

puts "Seeding finished."

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
