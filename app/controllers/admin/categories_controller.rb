class Admin::CategoriesController < Scaffold::Controller

  inherit_resources
  
  index do
    columns [:name]
    linked_column :name
    actions :edit, :delete, :move_up, :move_down
  end
  
  edit do
    columns [:name]
  end
  
  def update
    update! do |success, failure|
      success.html { raise options.inspect }
    end
  end
  
  def move_up
    resource.move_higher
    redirect_to :action => :index
  end
  
  def move_down
    resource.move_lower
    redirect_to :action => :index
  end
  
  protected
  
    def resource
      end_of_association_chain.find_by_url(params[:id])
    end
  
end