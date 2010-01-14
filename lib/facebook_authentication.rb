module FacebookAuthentication

  def self.included(base)
    base.class_eval do
      helper_method :current_user
      helper_method :facebook_session
      helper_method :logged_in?
      helper_method :session_url_hash

      before_filter :create_facebook_session
      before_filter :set_user_timezone
      
      rescue_from Facebooker::Session::SessionExpired, :with => :expire_facebook_session
    end
  end
  
  def logged_in?
    !current_user.nil?
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && User.find_by_facebook_uid(current_user_session.user.uid)
    Authorization.current_user = @current_user
  end
  
  def session_url_hash
    session_key = ActionController::Base.session_options[:key]
    hash = {
      session_key => cookies[session_key],
      request_forgery_protection_token => form_authenticity_token,
      :secret_from_session => current_user_session.secret_from_session
    }
    
    fb_cookie_names.each { |name| hash[name] = cookies[name] }
    return hash
  end

  private  

    def create_facebook_session
      super && verify_facebook_session
    end

    def current_user_session
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = facebook_session
    end  

    def set_user_timezone
      # Time.zone = current_user.time_zone if logged_in?
    end
    
    def expire_facebook_session
      clear_fb_cookies!
      clear_facebook_session_information
      reset_session
      redirect_to root_url
    end
    
    def verify_facebook_session
      return true
      begin
        session_key = current_user_session.session_key
        x = current_user_session.post('facebook.users.getLoggedInUser', :session_key => session_key)
        
        # catch a hijacker
        fb_user_id = params[:fb_sig_canvas_user] || params[:fb_sig_user]
        raise if fb_user_id && fb_user_id.to_i != current_user_session.user.id
      rescue Exception => e
        raise 
      end
    end

end