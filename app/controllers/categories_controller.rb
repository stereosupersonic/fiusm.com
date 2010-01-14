class CategoriesController < ApplicationController

  inherit_resources
  actions :show

  protected
  
    def resource
      @category ||= end_of_association_chain.find_by_url!(params[:category])
    end

end