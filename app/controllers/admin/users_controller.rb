class Admin::UsersController < Scaffold::Controller

  inherit_resources

  def show
    redirect_to :action => :edit
  end

  index do
    columns [:name]
    linked_column :name
    actions []
  end
  
  edit do
    
  end
  
  def publish
    resource.publish!
    redirect_to :action => :show
  end
  
  def retract
    resource.retract!
    redirect_to :action => :show
  end
    
  def resource_with_revision
    params[:revision] ? resource_without_revision.find_revision(params[:revision]) : resource_without_revision
  end
  alias_method_chain :resource, :revision
  
  helper_method :latest_article
  def latest_article
    resource_without_revision
  end

end