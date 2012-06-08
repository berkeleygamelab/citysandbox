class BetausersController < ApplicationController
  # GET /betausers
  # GET /betausers.json
  def index
    @betausers = Betauser.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @betausers }
    end
  end

  # GET /betausers/1
  # GET /betausers/1.json
  def show
    @betauser = Betauser.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @betauser }
    end
  end

  # GET /betausers/new
  # GET /betausers/new.json
  def new
    @betauser = Betauser.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @betauser }
    end
  end

  # GET /betausers/1/edit
  def edit
    @betauser = Betauser.find(params[:id])
  end

  # POST /betausers
  # POST /betausers.json
  def create
    @betauser = Betauser.new(params[:betauser])

    respond_to do |format|
      if @betauser.save
        format.html { redirect_to @betauser, notice: 'Betauser was successfully created.' }
        format.json { render json: @betauser, status: :created, location: @betauser }
      else
        format.html { render action: "new" }
        format.json { render json: @betauser.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /betausers/1
  # PUT /betausers/1.json
  def update
    @betauser = Betauser.find(params[:id])

    respond_to do |format|
      if @betauser.update_attributes(params[:betauser])
        format.html { redirect_to @betauser, notice: 'Betauser was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @betauser.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /betausers/1
  # DELETE /betausers/1.json
  def destroy
    @betauser = Betauser.find(params[:id])
    @betauser.destroy

    respond_to do |format|
      format.html { redirect_to betausers_url }
      format.json { head :ok }
    end
  end
end
