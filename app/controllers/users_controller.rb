class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def edit
    @user = User.find(session[:user_id])
  end

  def create
    @user = User.new(params[:user])
    if(@user.location != nil)
      a = Geocoder.coordinates(@user.location)
      @user.lat = a[0].to_s
      @user.lng = a[1].to_s
    end
    if @user.save
      redirect_to new_session_path
    else
      render "new"
    end
  end
  
  def update
     @user = User.find(session[:user_id])

     respond_to do |format|
       if @user.update_attributes(params[:user])
         format.html { redirect_to summary_path, notice: 'Question was successfully updated.' }
         format.json { head :ok }
       else
         format.html { render action: "edit" }
         format.json { render json: @question.errors, status: :unprocessable_entity }
       end
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
  
  respond_to :json
  
  def recent
    @user = User.find(session[:user_id])
    redirect_to
    respond_with(@user.recent_activity)
  end
end
