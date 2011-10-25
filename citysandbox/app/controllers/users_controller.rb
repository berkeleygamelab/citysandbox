class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to new_session_path
    else
      render "new"
    end
  end
  
  def destroy
    if not User.exists?(params[:user])
      redirect_to root_url, :notice => "User not found"
    else
      @u = User.find(params[:user])
    end
    @u.destroy
    respond_to do |format|
      format.html {redirect_to root_url, :notice => "User destroyed!"}
      format.xml {head :ok}
    end
  end
end
