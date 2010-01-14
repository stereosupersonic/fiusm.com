class Admin::AttachmentsController < Scaffold::Controller
  
  inherit_resources

  def create
    asset_class = params[:asset_type].constantize
    raise unless asset_class.attachable?
    
    @attachment = Attachment.new
    @attachment.owner = owner
    @attachment.asset = params[:asset_id] ? asset_class.find(params[:asset_id]) : asset_class.new
    create!
  end

  def show
    redirect_to polymorphic_url([:admin, resource.asset])
  end
  
  def destroy
    destroy! { :back }
  end

  protected

    helper_method :owner
    def owner
      @owner ||=
        if params[:attachment]
          owner_class = params[:attachment][:owner_type].classify.constantize
          owner_class.find(params[:attachment][:owner_id])
        else
          Article.find(params[:article_id])
        end
    end
  
end