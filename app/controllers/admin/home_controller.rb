class Admin::HomeController < Admin::ApplicationController
  def show
    redirect_to admin_articles_url
  end
end