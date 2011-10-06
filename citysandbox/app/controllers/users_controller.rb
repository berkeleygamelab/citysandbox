class UsersController < ApplicationController

  def index
    @questions = Question.find(:all)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to summary_path, :notice => "Signed up!"
    else
      render "new"
    end
  end
end
