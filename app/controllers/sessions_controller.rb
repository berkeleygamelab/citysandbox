class SessionsController < ApplicationController

  def create
    user = User.find_by_login(params[:login])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to summary_path
    else
      redirect_to home_login_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end
end
