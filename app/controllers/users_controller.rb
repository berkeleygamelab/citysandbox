class UsersController < ApplicationController

  def random_string(len)
    chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
     newpass = ""
     1.upto(len) { |i| newpass << chars[rand(chars.size-1)] }
     return newpass
  end
  
  def generate_random_authlogic()
    random_length = 10
    temp = random_string(random_length)
    temp_pwd = temp
    return temp_pwd
  end
  
  def new
    @user = User.new
  end

  def edit
    @user = User.find(session[:user_id])
  end

  def create
    #picturePotential = upload_image(params[:user][:picture])
   # params[:user][:picture] = picturePotential[0].url
    
    @user = User.new(params[:user])
    @user.temp_pwd = generate_random_authlogic()
    if(@user.location != nil)
      a = Geocoder.coordinates(@user.location)
      #@user.lat = a[0].to_s
      #@user.lng = a[1].to_s
    end
    if params[:user][:upload] != nil
      upload_image(@user, params[:user][:upload])
    else
      @user.picture = "DEFAULT"
    end
    if @user.save
      stuff = params[:upload]
      
      if params[:upload] == nil
        puts "HU HO"
        
      end
      puts "LE PICTURE"
     # @user.picture = picturePotential[0].url
      #@user.save
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
  
  def profile
    @user = User.find(params[:id])
    @followed_user = current_user.followees.where(:followee_id => @user_id).size != 0
  end
  
  respond_to :json
  
  def recent
    @user = User.find(session[:user_id])
    redirect_to
    respond_with(@user.recent_activity)
  end
  
  def validate
    id = params[:user]
    val = params[:token]
    @validated = false
    if(val != nil and id != nil)
      @validated = (User.where(:id => id).first.temp_pwd == val)
      user = User.where(:id => id)
      user.verified = @validated
      user.save
    end
  end
  
  def upload_image(user, uploaded_file)
    puts "attempting to do shit with the image"
    name =  uploaded_file.original_filename
        
         #create the file path
        path = File.join("tmp", name)
        # write the file
       File.open(path, "wb") { |f| f.write(uploaded_file.read) }
        
      #a = 0 / 0
      item = Fleakr.upload(path)
      user.picture = "DEFAULT"
      if item != nil
        if item[0] != nil
          user.picture = item[0].url
        end
      end
    
  end

end
