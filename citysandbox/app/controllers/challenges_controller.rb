class ChallengesController < ApplicationController

  # GET /challenges/1
  # GET /challenges/1.json
  def show
    @challenge = Challenge.find(params[:id])
    @category = Categories.find(@challenge.categories_id)
    @can_vote = vote_permission(current_user)
    @most_popular_proposal = @challenge.most_popular_proposal()
    @can_submit = @challenge.submission_deadline > Time.now
    
    @followed = current_user.followed_challenges.where(:id => params[:id]).size != 0
    @followed_user = current_user.followed_users.where(:followed_user_id => @challenge.user_id).size != 0
    puts @followed
    puts @followed_user
    puts "ROKKUGO ROKKUGO PAH PAH PAH"
    puts current_user.id
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @challenge }
    end
  end
  
  def vote_permission(user)
    if @challenge.vote_deadline > Time.now
      temp = @challenge.proposals
      temp.each do |x|
        if VotingRecord.where(:proposal_id => x.id).where(:user_id => user.id).first != nil
          return false
        end
      end
      return true
    end
    return false
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
        @challenge.insert_location(@challenge.lat + ', ' + @challenge.lng)
        format.html { redirect_to @challenge.question, notice: 'Challenge was successfully created.' }
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
