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
      puts "DUFF MAN IS IN THE HOOS"
      puts "check if the name is null"
      puts "name: " 
      puts name
      
      coordinates = params["coordinates"]
      puts coordinates
      #coordinates = coordinates.split(",")
      #coordinates.gsub(//, " ")
     
      # puts coordinates
  
      taggedarea = TaggedArea.new(:title => name)
      
      #make sure areas are saving
      if taggedarea.save
          #all coordinates associated with this tagged area based on id
          
        
	  #treating coordinates as a LIST OF TUPLES 
	     
          coordinates.each do |set|
	      t = set.split(",")
              c = t[0] + "," + t[1]
              newcoord = Coordinate.new("tagged_area_id" => taggedarea.id, :location => c)
	      #MAKE SURE THAT COORDS ARE SAVING
	      newcoord.save
	  end
       end
   end
   
   def draw_map
     puts "what is going on here"
   end
          
      	
  def query_filter
      area = params["taggedArea"]
      @taggedAreas =  TaggedArea.where(:name => area)
      return @taggedAreas
  end

  #NEEDS AN ID, separate function for finding out this id when user selects?
  def coordinatesForArea
      areaID = params["areaID"]
      @coordinates = Coordinate.where(:Area_id => areaID)
      return @coordinates
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
  
  def drawMapConfirm
    @table = ENV['csb_locations']
  end

    #given an area id it checks if this area has certain overlap with new points
    #for each individual area...
    #finds center of the polygon using simple average of x and y coordinates
    #finds the average distance from center to each point 
    #compares the distances between the two centers
    #takes MIN average distance and then does avg_dist/center_dist
    # if this value has a ratio of 0.8 or better it will return true
    # this constant value should be adjusted as needed

    def error_estimation(area_id, points)
    	a_points = Coordinate.find(:id => area_id)
	centerx1 = 0
	centery1 = 0
	 a_points.each do |point|
	   centerx1 += point.location[0]
	   centery1 += point.location[1]
  end
	centerx1 = centerx1 / a_points.length
	centery1 = centery1 / a_points.length
	
        centerx2 = 0
	centery2 = 0
	 points.each do |point|
	    centerx2 += point.location[0]
	    centery2 += point.location[1]
	end
	centerx2 = centerx2 / points.length
	centery2 = centery2 / points.length

	avg_dist1 = 0
	 a_points.each do |point|
	    x = (centerx1 - point.location[0]) ** 2
	    y = (centery1 - point.location[1]) ** 2
	    avg_dist1 += Math.sqrt(x + y)
	end
	avg_dist1 = avg_dist1 / a_points.length

        avg_dist2 = 0
	 points.each do |point|
	    x = (centerx2 - point.location[0]) ** 2
	    y = (centery2 - point.location[1]) ** 2
	    avg_dist1 += Math.sqrt(x + y)
	end
	avg_dist2 = avg_dist2 / a_points.length

	center_dist_x = (centerx1 - centery1) ** 2
	center_dist_y = (centerx2 - centery2) ** 2
	center_dist = Math.sqrt(center_dist_x + center_dist_y)

	if (avg_dist1 > avg_dist2)
		return avg_dist2/center_dist > 0.8
	else
		return avg_dist1/center_dist > 0.8
    end
  end