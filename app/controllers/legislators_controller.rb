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
    @sponsored_bills = @legislator.sponsored_bills
    @bills = @legislator.bills.uniq.map do |bill|
      {
        vote: bill.votes.where(voter_id: @legislator.id).last.vote_type,
        title: bill.official_title,
        id: bill.id
      }
    end
    first_bill = Bill.order(last_vote_at: :asc).first
    @first_bill_date = first_bill.last_vote_at if first_bill

    @top_contributions = @legislator.top_contributions

    #=> {0=>["National Assn of Realtors", "11500"], 1=>["Coca-Cola Co", "10500"], 2=>["Home Depot", "10500"]}

  end



end
