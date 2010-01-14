class Admin::ImagesController < Scaffold::Controller
  
  inherit_resources

  protect_from_forgery :except => :create
  
  def destroy
    destroy! { :back }
  end
  
  def create
    create! do |success, failure|
      success.html { render :nothing => true }
    end
  end
  
  def update
    update! { [:admin, @image.gallery || @image] }
  end
  
  protected
  
    def end_of_association_chain
      params[:gallery_id] ? Gallery.find(params[:gallery_id]).images : resource_class
    end
  
end