class UsersController < ApplicationController
  
  skip_before_filter :verify_facebook_session
  
  def create
    facebook_user = current_user_session.user
    unless User.find_by_facebook_uid(facebook_user.uid)
      User.create(:name => facebook_user.name.to_s, :facebook_uid => facebook_user.uid)
    end

    redirect_to root_url
  end

end