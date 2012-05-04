class GroupsController < ApplicationController

  def index
    
    size_limit_questions = 15
     size_limit_discussion = 5
     page_offset = 0
     @collection = []
     @flagsort = false
     @cat_ids = params[:category] # it's an array of integers
     @startDate = params[:timeBefore]
     @endDate = params[:timeAfter]
     @types = params[:types] #array of strings that specifies what type of item we're filtering for; names like question, challenge, event

     @area_to_filter = params[:area_id]

     if @endDate==nil
       @endDate = Time.now
     end
     @events = []

     @questions = []
     @challenges = []
     @location_to_grab = params[:loc]
     @target_user = params[:by_user]
     @radius = params[:radius]
     @following = params[:following]
     @popular = params[:popular]

     @pages = params[:pages]
     #set default pages
     if(@pages == nil)
       @pages = 10
     end

     @default_categories = Category.where(:default_cat => true)
     @my_categories = []
     @popular_categories = []
     @my_areas = []


     if(@location_to_grab == nil)
       if !current_user.nil?
         @location_to_grab = current_user.lat.to_s + " " + current_user.lng.to_s
         @my_categories = current_user.categories
         @my_areas = current_user.tagged_areas
       end
       if current_user.nil?
         @error = "ERROR"
         @items = ItemTemplate.paginate(:page => params[:page]).where(:id => nil)
         return nil
       end
     else
       @location_to_grab = params[:location]
       loc = Geocoder.coordinates(@location_to_grab)
       @location_to_grab = loc[0].to_s + " " + loc[1].to_s
       if !current_user.nil?
         @my_categories -= current_user.categories
       end
     end


     @keyword = params[:keyword]
     if @types == nil
       @types = ["Question","Challenge","Event"]
     end 
     @dummy = ItemTemplate.new
     if @radius == nil
       @radius = 25000
     end


     if !@area_to_filter.nil?
       @items = @area_to_filter.grab_items(@types)
     else
       @items = @dummy.grab_circle_type(@radius, @location_to_grab, @types)
     end



     if !@startDate.nil? and !@endDate.nil?
       @between = @startDate..@endDate
       @items = @items.where(:updated_at => @between)
     end

     if !@cat_ids.nil?
       @items = @items.joins(:categoryholders).where("categoryholders.category_id" => @cat_ids).uniq
     end

    @collection = @items
    @items =  @items.paginate(:page => params[:page], :per_page => 5)
    #uts @items
    @item_templates = ItemTemplate.paginate(:page => params[:page], :per_page => 5)

  end
end
