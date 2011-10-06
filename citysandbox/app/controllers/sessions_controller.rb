class SessionsController < ApplicationController

  def create
    user = User.find_by_login(params[:login])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to summary_path, :notice => "Logged in!"
    else
      flash.now.alert = "Invalid email or password"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Logged out!"
  end
end
