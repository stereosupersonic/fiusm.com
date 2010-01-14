class Admin::Designer::CanvasesController < Admin::ApplicationController
  inherit_resources
  defaults :resource_class => Canvas, :collection_name => 'canvases', :instance_name => 'canvas'
  
  def show
    redirect_to :action => :edit
  end

end