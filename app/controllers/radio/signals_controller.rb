class Radio::SignalsController < RadioController
  def index
    @towers = RadioTower.find(:all)
  end
end