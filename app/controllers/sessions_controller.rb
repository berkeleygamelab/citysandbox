class SessionsController < ApplicationController

  def create
    @user = User.new
    puts "WHAT"
    puts params[:login]
    puts params[:password]
    user = User.where(:login => params[:login]).first
    puts user

    if user && user.cheatAuth(params[:password])
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
