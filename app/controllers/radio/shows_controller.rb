class Radio::ShowsController < RadioController
  
  def index
    @genres = RadioGenre.find(:all, :order => 'name asc')
  end
  
  def show
    @show = RadioShow.find_by_permalink(params[:id])
  end
  
end