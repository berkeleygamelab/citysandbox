class MapController < ApplicationController
  def index
    @location = params[:city_input]
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @location }
    end
  end
  
  respond_to :json
  
  def draw
      #creating new tagged area
      name = params["taggedArea"]
      taggedarea = TaggedArea.new(:title => name)
      
      if taggedarea.save
          #all coordinates associated with this tagged area based on id
          coordinates = params["coordinates"]

	  #treating coordinates as a LIST OF TUPLES 
          coordinates.each do |t|
	      c = t[0] + "," + t[1]
              newcoord = Coordinate.new(:tagged_area_id => taggedarea.id, :location => c)
	      newcoord.save
	  end
      end
   end
   
   def draw_map
     
   end
          
      	
  def query_filter
      area = params["taggedArea"]
      @taggedAreas =  TaggedArea.where(:name => area)
      return @taggedAreas
  end

  def get_info
    @entry = {}
    if (params[:category] == 'questions') 
      @item = Question.find(params[:id])
      entry_stats = {}
      entry_stats['Response'] = @item.response_questions.length
      entry_stats['Follower'] = @item.followed_questions.length
      entry_stats['Challenge'] = @item.challenges.length
      num_events = 0
      @item.challenges.each { |challenge| 
        num_events += challenge.events.length
      }
      entry_stats['Event'] = num_events
      @entry['stats'] = entry_stats
    elsif (params[:category] == 'challenges') 
      @item = Challenge.find(params[:id])
      entry_stats = {}
      entry_stats['Response'] = @item.response_challenges.length
      entry_stats['Follower'] = @item.followed_challenges.length
      entry_stats['Proposal'] = @item.proposals.length
      entry_stats['Event'] = @item.events.length
      @entry['stats'] = entry_stats
    elsif (params[:category] == 'events') 
      @item = Event.find(params[:id])
      entry_stats = {}
      entry_stats['Response'] = @item.response_events.length
      entry_stats['Follower'] = @item.followed_events.length
      @entry['stats'] = entry_stats
    end
    
    @entry['item'] = @item
    @entry['user'] = @item.user
    @entry['type'] = params[:category]
    @entry['created_at_formatted'] = @item.created_at.strftime("%Y %b %d")
    
    respond_with(@entry)
  end

end
