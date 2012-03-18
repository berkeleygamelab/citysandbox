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
	

end
