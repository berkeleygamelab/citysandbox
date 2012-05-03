class SessionsController < ApplicationController

  def create
    @user = User.new
    user = User.find_by_login(params[:login])
    if !user.nil?
      user.password = user.password_digest
      puts "I LIKE TO HERP IT HERP IT"
      puts params[:password]
      puts "DERP IT "
    end
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to "/filter"
    else
      redirect_to "fail"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end

  def new
  @user = User.new
  end
end
