class Admin::Designer::ColumnsController < Admin::ApplicationController

  def new
    create
  end
  
  def create
    canvas.columns << Column.new(canvas)
    canvas.save
    redirect_to admin_designer_canvas_url(canvas)
  end

  def show
    redirect_to :action => :edit
  end
  
  def index
    @columns = canvas.columns
  end
  
  def edit
    column
  end
  
  def update
    column
  end
  
  protected
  
    def canvas
      @canvas ||= Canvas.find(params[:canvas_id])
    end

end