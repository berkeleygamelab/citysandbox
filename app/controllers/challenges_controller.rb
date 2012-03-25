 def retrieve_google(db_return)
    rtn = []
    db_return.each do |x|
      rtn += [x[:id]]
    end
    return Question.followed(rtn)
  end
class ChallengesController < ApplicationController

  # GET /challenges/1
  # GET /challenges/1.json
  def show
    if current_user == nil
      redirect_to home_login_url
    else 
      @challenge = Challenge.find(params[:id])
      @category = Category.find(@challenge.item_template.cat_id)
      @vote = vote_permission(current_user)
      @most_popular_proposals = @challenge.most_popular_proposal()
      @can_submit = @challenge.submission_deadline > Time.now

      @followed = current_user.followed_challenges.where(:challenge_id => params[:id]).size != 0
      @followed_user = current_user.followed_users.where(:followed_user_id => @challenge.user_id).size != 0

      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @challenge }
      end
    end
  end

  def challengeNew
    @challenge = Challenge.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @challenge }
    end
  end
  
  def vote_permission(user)
    temp = @challenge.proposals
    temp.each do |x|
      if Vote.where(:proposal_id => x.id).where(:user_id => user.id).first != nil
        return x.id
      end
    end
    if @challenge.vote_deadline > Time.now
      return -1
    end
    return 0

  end
  

  # GET /challenges/new
  # GET /challenges/new.json
  def new
    @challenge = Challenge.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @challenge }
    end
  end

  # GET /challenges/1/edit
  def edit
    @challenge = Challenge.find(params[:id])
  end

  # POST /challenges
  # POST /challenges.json
  def create
    @challenge = Challenge.new(params[:challenge])
    @challenge.question_id = params[:challenge][:question_id]
    @challenge.question = Question.find(params[:challenge][:question_id])
    @challenge.user_id = current_user.id

    respond_to do |format|
      if @challenge.save
        @temp = Geocoder.coordinates(@challenge.location)
        @challenge.lat = @temp[0].to_s
        @challenge.lng = @temp[1].to_s
        @challenge.insert_location(@challenge.lat + ', ' + @challenge.lng)
        format.html { redirect_to @challenge, notice: 'Challenge was successfully created.' }
        format.json { render json: @challenge, status: :created, location: @challenge }
      else
        format.html { render action: "new" }
        format.json { render json: @challenge.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /challenges/1
  # PUT /challenges/1.json
  def update
    @challenge = Challenge.find(params[:id])

    respond_to do |format|
      if @challenge.update_attributes(params[:challenge])
        format.html { redirect_to @challenge, notice: 'Challenge was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @challenge.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /challenges/1
  # DELETE /challenges/1.json
  def destroy
    @challenge = Challenge.find(params[:id])
    @challenge.destroy

    respond_to do |format|
      format.html { redirect_to challenges_url }
      format.json { head :ok }
    end
  end
end
