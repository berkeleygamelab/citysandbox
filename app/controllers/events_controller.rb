class EventsController < ApplicationController
  # GET /events/1
  # GET /events/1.json
   autocomplete :category, :name
  def show
    if current_user == nil
      redirect_to home_login_url
    else
      @event = Event.find(params[:id])
      @category = Categories.find(@event.categories_id)\
    
      @followed = current_user.followed_events.where(:event_id => params[:id]).size != 0
      @followed_user = current_user.followed_users.where(:followed_user_id => @event.user_id).size != 0

      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @event }
      end
    end
  end

  # GET /events/new
  # GET /events/new.json
  def new
    @event = Event.new
@category = Category.new
@sample = Question.all.pop
@samples = @sample.kludgy_related_similar()
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @event }
    end
  end

  def eventNew
  @event = Event.new 
  @category = Category.new
  @sample = Question.all.pop
  @samples = @sample.kludgy_related_similar()
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(params[:event])
    @event.challenge_id = params[:challenge_id]
    @event.user_id = current_user.id

    respond_to do |format|
      if @event.save
        @temp = Geocoder.coordinates(@event.location)
        @event.lat = @temp[0].to_s
        @event.lng = @temp[1].to_s
        @event.insert_location(@event.lat + ', ' + @event.lng)
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render json: @event, status: :created, location: @event }
      else
        format.html { render action: "new" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.json
  def update
    @event = Event.find(params[:id])

    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :ok }
    end
  end
end
