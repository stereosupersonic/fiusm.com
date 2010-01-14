require 'open-uri'
require 'rss/2.0'
require 'nokogiri'

class Admin::ArticlesController < Scaffold::Controller
  
  inherit_resources

  index do
    columns :created_at, :status, :headline
    linked_column :headline
    actions :edit, :delete
  end

  def update
    update!

    actions = params[:article_actions] || {}
    if actions[:update_published_version]
      resource.update_published_version!
    end
  end

  def show
    redirect_to :action => :edit
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
  
  protected
  
    def collection
      end_of_association_chain.paginate :page => params[:page], :per_page => 15
    end

end