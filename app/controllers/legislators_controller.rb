class LegislatorsController < ApplicationController

  def index
    @reps = Legislator.where(chamber: "house").limit(5)
    @senators = Legislator.where(chamber: "senate").limit(2)
  end
end
