class Radio::HomeController < RadioController
  def index
    @events = RadioShowEvent.upcoming
  end
end
