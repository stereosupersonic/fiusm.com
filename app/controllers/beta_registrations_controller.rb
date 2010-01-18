class BetaRegistrationsController < ApplicationController

  layout false

  def index
    if current_user_session
      begin
        fb_user = current_user_session.user
        if @registration = BetaRegistration.find_by_facebook_uid(fb_user.uid)
          # do nothing
        else
          @new_record = true
          @registration = BetaRegistration.find_or_create_by_name_and_facebook_uid(fb_user.name, fb_user.uid)
        end
      rescue Facebooker::Session::SessionExpired
      end
    end
  end

end
