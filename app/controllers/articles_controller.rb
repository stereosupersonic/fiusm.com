require 'iconv'

class ArticlesController < ApplicationController
  inherit_resources
  actions :index, :show

  def show
    # parameters = {
    #   :post_id => '207778937892',
    #   :comment => 'Whoa!'
    # }
    # facebook_session.post('facebook.stream.addComment', parameters)
    # 
    # # raise facebook_session.fql_query('SELECT object_id, fromid, time, text, id, username, xid, post_id FROM comment WHERE post_id = "207778937892_207807317892"').to_yaml
    # 
    # parameters = {
    #   :comment => resource.headline,
    #   :url => url_for(resource),
    #   :uid => 207778937892
    # }
    # x = facebook_session.post('facebook.links.post', parameters) rescue nil
    # raise x.inspect
    # resource.viewed!
    @comments = resource.comments.paginate(:page => params[:page], :per_page => 10)
    resource.viewed!
    
    show!
  end
  
  def index
    @featured    = category.articles.featured
    @highlighted = category.articles.highlighted
  end
  
  protected

    def end_of_association_chain
      (category.try(:articles) || resource_class)
    end
    
    helper_method :category
    def category
      @category ||=
        if params[:category_id]
          Category.find(params[:category_id])
        elsif params[:category_url]
          Category.find_by_url(params[:category_url])
        else
          nil
        end
    end

end