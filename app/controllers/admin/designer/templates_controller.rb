class Admin::Designer::TemplatesController < Admin::ApplicationController
  inherit_resources
  defaults :resource_class => CanvasTemplate, :collection_name => 'canvas_templates', :instance_name => 'canvas_template'
  
  def create
    create! { { :action => :index } }
  end
  
  def update
    update! { { :action => :index } }
  end
  
  def show
    redirect_to :action => :edit
  end
  
  def collection
    @item_templates ||= end_of_association_chain.find(:all, :order => 'name ASC')
  end
end
