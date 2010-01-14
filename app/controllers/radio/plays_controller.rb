class Radio::PlaysController < RadioController
  def index
    @plays = SongPlay.played.paginate :page => params[:page]
  end
end