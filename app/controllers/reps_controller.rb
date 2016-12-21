class RepsController < ApplicationController

  def index
    @reps = Rep.where(house: "House")
    @senators = Rep.where(house: "Senate")
  end

  def show
  end

end
