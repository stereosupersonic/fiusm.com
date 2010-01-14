class ApplicationController < ActionController::Base
  helper :all
  protect_from_forgery

  include FacebookAuthentication

  #
  # Path helpers
  #

  helper_method :article_path
  def article_path(*args)
    if article = (args[0].is_a?(Article) || args[0].is_a?(ArticleRevision)) && args[0]
      begin
        path = { :category => article.primary_category.url,
                 :year  => article.publish_at.year,
                 :month => article.publish_at.month,
                 :day   => article.publish_at.day,
                 :id    => article.to_param }
        "#{path[:category]}/#{path[:year]}/#{path[:month]}/#{path[:day]}/#{path[:id]}"
      rescue NoMethodError
        "/articles/#{article.to_param}"
      end
    else
      raise "First argument must be an Article"
    end
  end
  
  helper_method :article_url
  def article_url(*args)
    root_url + article_path(*args)
  end
  
  helper_method :article_revision_path
  def article_revision_path(*args)
    article_path(*args)
  end

end
