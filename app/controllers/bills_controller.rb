class BillsController < ApplicationController

  def show
    @bill = Bill.find(params[:bill_id])
    final_vote = @bill.votes.where(voted_at: @bill.last_vote_at)

    votes_for = final_vote.where(vote_type: "Yea").uniq
    votes_against = final_vote.where(vote_type: "Nay").uniq
    republicans = Legislator.where(party: "R")
    democrats = Legislator.where(party: "D")
    independents = Legislator.where(party: "I")
    @voters_for = {
      d: votes_for.where(legislator: republicans).uniq.count,
      r: votes_for.where(legislator: democrats).uniq.count,
      i: votes_for.where(legislator: independents).uniq.count,
    }
    @voters_against = {
      d: votes_against.where(legislator: republicans).uniq.count,
      r: votes_against.where(legislator: democrats).uniq.count,
      i: votes_against.where(legislator: independents).uniq.count,
    }

    reps = Legislator.find(session[:reps])
    @rep_votes = reps.map { |rep| final_vote.where(voter_id: rep).last }
    @rep_votes.delete(nil)

  end
end
