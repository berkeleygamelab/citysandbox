class ItemTemplate < ActiveRecord::Base
	belongs_to :item, :polymorphic => true
	belongs_to :category, :foreign_key => "cat_id"
	has_many :notification
	has_many :users, :through => :subscriptions	
	has_many :response_templates
	validates :user_id, :presence => true
    validates :title, :presence => true
    validates :location, :presence => true 
	scope :followed, lambda{|key| {:conditions => {:id => key}}}
	scope :has_category,       lambda{ |n| { :conditions => { :categories_id => n}}}
	scope :has_title, lambda{|name| {:conditions => ["title LIKE ? OR title LIKE ? OR title LIKE ?", "% " + name + " %", name, name + " %"]}}
	scope :keyword, lambda{|key| {:conditions => ["title LIKE ? OR title LIKE ? OR title LIKE ? OR description LIKE ? OR description LIKE ? OR description LIKE ?", "% " + key + " %", key, key + " %", "% " + key + " %", key, key + " %" ]}}
	
	def category_id
      return cat_id
	end
	
	def generate_content
	    @title = title
		@location = location
		@cat_name = Category.find(cat_id)
		@description = description
		@created_at = created_at
		@updated_at = updated_at
		@update_time = update_time
		@popularity = popularity
		case type
			when "question"
				Question.find(item_id).generate_content
			when "event"
				Event.find(item_id).generate_content
			when "challenge"
				Challenge.find(item_id).generate_content
			when "project"
				Project.find(item_id).generate_content
			when "group"
				Group.find(item_id).generate_content
	end

	def create_followed(follower)
		followed = subscription.new
		followed.user_id = follower.id
		followed.item_template_id = item_template.id
		if subscription.where(:item_template_id=> id).where(:user_id => follower.id) == []
			followed.save
		end
	end
<<<<<<< HEAD
	def most_popular(since_last)
		return challenge.find(:all, :conditions => ["updated_at > "]).where()
   end

        def fetch_location
	    @table = ENV['csb_locations']
	    return ::FT.execute "SELECT Location FROM #{@table} WHERE ID = #{item_id} AND Type = ItemTemplate.type "

        #takes in a CSV of lat/lng and either quest, chall, or event
   	def insert_location(location)
	    @table = ENV['csb_locations']
	    return ::FT.execute "INSERT INTO #{@table} (ID, Type, Location, Category) VALUES (#{who.id}, #{ItemTemplate.type}, '#{location}', #{ItemTemplate.cat_id} "
	end

        #takes in a CSV of lat/lng and either quest, chall, or event
	def update_location(location)
	    @table = ENV['csb_locations']
	    @sanity_check = ::FT.execute "SELECT rowid FROM #{@table} WHERE ID = #{who.id} AND Type = #{ItemTemplate.type} "
	    if @sanity_check[0] == nil
	        return insert_location(location)
	    end
	    @rowid = @sanity_check[0][:rowid]

	    return ::FT.execute "UPDATE #{@table} SET Location = '#{ItemTemplate.location}' WHERE ROWID = '#{@rowid}' AND Type = #{ItemTemplate.type}
	end

        #takes in a limit and either quest, chall, or event
	def grab_nearest(limit)
	    @table = ENV['csb_locations']
	    @lat = ItemTemplate.location.split(',')[0].to_f
	    @lng = ItemTemplate.location.split(',')[1].to_f
	    return ::FT.execute "Select * FROm #{@table} WHERE Type = ItemTemplate.type ORDER BY ST_DISTANCE(Location, LATLNG(#{@lat},#{@lng})) LIMIT #{limit}
	end
	
	
	def grab_circle(radius, target_loc, number, who)
	    @table = ENV['csb_locations']
	    @lat = target_loc.split[0].to_f
	    @lng = target_loc.split[1].to_f
	    reeturn ::FT.execute "SELECT * FROM #{@table} WHERE ST_INTERSECTS(Location, CIRCLE(LATLNG(#{@lat}, #{@lng}, #{radius})) AND Type = ItemTemplate.type "
	end

	def sift_circle(radius, target_loc, number, set)
	    circles = grab_cirle(distance, target_loc, number)
	    circles = retrieve_google_with_set(set, circles)
	    return circles
	end

	def retrieve_google_with_set(set, db_return)
	    rtn = []
	    db_return.each do |x|
	        rtn += [x[:item_id]]
	    end
	    return set.followed(rtn)
	end

	def grab_rectangle(upper_right, lower_left)
	    @table = ENV['table']
	    @upper_right_x = upper_right.split[0].to_f
	    @upper_right_y = upper_right.split[1].to_f
	    @lower_left_x = lower_left.split[0].to_f
	    @lower_left_y = lower_left.split[1].to_f
	    return ::FT.execute "SELECT * FROM #{@table} WHERE ST_INTERSECTS (Location, RECTANGLE(LATLNG(#{@upper_right_x}, #{@upper_right_y}), LATLNG(#{@lower_left_x}, #{@lower_left_y}))) AND Type = ItemTemplate.type"
	    end

	def retrieve_entries(db_return)
	    rtn = []
	    db_return.each do |x|
	        rtn += [x[:item_id]]
	    end
	    return ItemTemplate.followed(rtn)
	end

	def combine_google_filter(db_return, set)
	    return set.where(:id => db_return)
	end

	def retrieve_google(db_return)
	    rtn = []
	    db_return.each do |x|
	        rtn += [x[:item_id]]
	    end
	    return ItemTemplate.followed(rtn)
	end

	#temporary most popular
	def most_popular(since_last, distance, target_location)
	    set = ItemTemplate.where("updated_at > '#{since_last}'").order("popularity DESC")
	    google_set = grab_circle(distance, target_location, 25)
	    google_fetch = retrieve_google(google_set)
	    return google_fetch.where("updated_at > '#{since_last}'").order("popularity DESC")
	 end
	
<<<<<<< HEAD
=======
	def most_popular(since_last, types)
		return ItemTemplate.find(:all, :conditions => ["updated_at > ? AND type IN (?)", since_last, types]).where()
    end

    def most_popular(since_last, types, distance, target_location)
       google_set = grab_circle(distance, target_location, 25)
       google_fetch = retrieve_google(google_set)
       return google_fetch.where("updated_at > '#{since_last}'").order("popularity DESC")
    end
	 
	def grab_circle(distance, target_loc, number)
     @events_table = ENV['csb_locations']
     @loc_x = target_loc.split[0].to_f
     @loc_y = target_loc.split[1].to_f

     return ::FT.execute "SELECT * FROM #{@events_table} WHERE ST_INTERSECTS(Location, CIRCLE(LATLNG(#{@loc_x}, #{@loc_y}), #{distance})) AND Origin = 'events'"
   end
   
   def grab_nearest(number)
	@item_table = ENV['csb_locations']
	@loc_x = location.split[0].to_f
	@loc_y = location.split[1].to_f
	return ::FT.execute "SELECT * FROM #{@item_table} ORDER BY ST_DISTANCE(Location, LATLNG(#{@loc_x},#{@loc_y})) LIMIT #{number}"
	
>>>>>>> 5b0a9759539d518faf82e28a4903072dc6b856cb

end
