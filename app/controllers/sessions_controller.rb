class SessionsController < ApplicationController

  def new
  end

  def create
    address = params[:address]
    coords = lat_long(address)
    sunlight_url =  "https://congress.api.sunlightfoundation.com/legislators/locate?latitude=#{coords[0]}&longitude=#{coords[1]}"
    json = HTTParty.get(sunlight_url)
    reps = []
    json["results"].each do |result|
      reps << Legislator.find_by_votesmart_id(result["votesmart_id"].to_s).id
    end
    session[:reps] = reps
    flash[:success] = "Found your legislators!"
    redirect_to legislators_path
  end

  private
    GOOGLE_MAPS_API_KEY = Rails.application.secrets.google_maps_api_key

    def lat_long(address)
      maps_query_url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{URI.encode(address)}&key=#{GOOGLE_MAPS_API_KEY}"
      json = HTTParty.get(maps_query_url)
      if json["status"] = "OK" && json["results"].length > 0
        [json["results"][0]["geometry"]["location"]["lat"], json["results"][0]["geometry"]["location"]["lng"]]
      end
    end

end
