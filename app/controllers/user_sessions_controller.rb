class UserSessionsController < ApplicationController

  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      redirect_to '/Loggedin!'
    else
      render :action => :new
    end
  end

  def destroy
    expire_facebook_session
    redirect_to root_url
  end

end