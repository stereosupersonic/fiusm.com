class ApplicationController < ActionController::Base
  helper :all
  protect_from_forgery

  before_filter :verify_beta_status unless RAILS_ENV =~ /development/i

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
  
  protected
  
  def verify_beta_status
    create_facebook_session
    uid = current_user_session.try(:user).try(:uid)

    if uid && BetaRegistration.find_by_facebook_uid_and_activated(uid, true)
      # do nothing
    else
      redirect_to beta_url unless controller_name == 'beta_registrations'
    end
  end

end
