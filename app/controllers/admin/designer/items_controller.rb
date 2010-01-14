class Admin::Designer::ItemsController < Admin::ApplicationController

  def new
    @item = CanvasItem.new
  end
  
  def create
    @item = CanvasItem.new
    @item.assignments = params[:item][:assignments]
    column.items << @item
    canvas.save
    redirect_to admin_designer_canvas_url(canvas)
  end
  
  helper_method :column, :column_index, :canvas
  
  protected
  
  def column
    @column ||= canvas.columns[column_index]
  end
  
  def column_index
    @column_index ||= params[:column_id].to_i
  end
  
  def canvas
    @canvas ||= Canvas.find(params[:canvas_id])
  end

end