class LegislatorsController < ApplicationController

  def index
    ids = session[:reps]
    @user = User.new
    @reps = []
    @senators = []
    ids.each do |id|
      current = Legislator.find_by_id(id)
      if current.chamber == "house"
        @reps << current
      elsif current.chamber == "senate"
        @senators << current
      end
    end
  end

  def show
    @legislator = Legislator.find_by_id(params[:id])
  end
end
