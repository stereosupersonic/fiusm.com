class Radio::StaffController < RadioController

  def index
    @manager   = RadioHost.find_by_level 'manager'
    @directors = RadioHost.find_all_by_level 'director', :order => 'name asc'
    @djs       = RadioHost.find_all_by_level 'dj'
  end

  def show
    @host = RadioHost.find_by_permalink(params[:id])
  end

end