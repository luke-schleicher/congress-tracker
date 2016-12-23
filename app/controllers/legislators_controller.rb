class LegislatorsController < ApplicationController

  def index
    bioguide_ids = session[:reps]
    @user = User.new
    @reps = []
    @senators = []
    bioguide_ids.each do |bioguide_id|
      current = Legislator.find(bioguide_id)
      if current.chamber == "house"
        @reps << current
      elsif current.chamber == "senate"
        @senators << current
      end
    end
  end

  def show
    @legislator = Legislator.find(params[:bioguide_id])
    @bills = @legislator.bills
    @first_bill_date = Bill.order(last_vote_at: :asc).first.last_vote_at
  end
end
