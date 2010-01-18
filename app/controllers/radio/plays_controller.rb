class Radio::PlaysController < RadioController

  inherit_resources
  defaults :resource_class => ::SongPlay
  
  def index
    @plays = SongPlay.played.paginate :page => params[:page]
  end
  
  def show
    ::Album.new("Pink Floyd", "Echoes")
  end
  
  protected
  
    def resource
      if params[:id] =~ /^latest$/i
        end_of_association_chain.latest
      else
        end_of_association_chain.find(params[:id])
      end
    end
  
end