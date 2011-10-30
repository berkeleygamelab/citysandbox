class Event < ActiveRecord::Base
  belongs_to :challenge
  belongs_to :question
  belongs_to :user
  belongs_to :categories
  belongs_to :challenge
  
  validates :categories_id, :presence => true
  
  has_many :response_events
  has_many :followed_events
  
  scope :followed, lambda{|key| {:conditions => {:id => key}}}
  
  scope :has_category,       lambda{ |n| { :conditions => { :categories_id => n}}}
  scope :has_title, lambda{|name| {:conditions => ["title LIKE ? OR title LIKE ? OR title LIKE ?", "% " + name + " %", name, name + " %"]}}

  def category_id
     return categories_id
  end
   
   
  def create_followed
    followed = FollowedEvent.new
    followed.user_id = current_user.id
    followed.event_id = id
    
    
    followed.save
  end
  
  def create_followed(follower)
    followed = FollowedEvent.new
    followed.user_id = follower.id
    followed.event_id = id
    if FollowedEvent.where(:event_id => id).where(:user_id => follower.id) == []
      followed.save
    end
  end
  
  def most_popular(since_last)
    return Question.where("updated_at > '#{since_last}'").where()
  end
  
  def remove_followed
     followed = followed_events
     a= followed.where(:user_id => current_user.id).first
     return a.destroy
   end
   
   def remove_followed(follower)
     followed = followed_events
     a = followed.where(:user_id => follower.id).first
     return a.destroy
   end
   
   def fetch_location
     @events_table = ENV['event_table']
     return ::FT.execute "SELECT Location FROM #{@events_table} WHERE id = #{id}"
   end    

   def update_location(loc)
     @events_table = ENV['event_table']
     @quest_dummy = ::FT.execute "SELECT rowid FROM #{@events_table} WHERE id = #{id}"
     if @quest_dummy[0] == nil
       return insert_location(loc)
     end
     @rowid = @quest_dummy[0][:rowid]
     
     return ::FT.execute "UPDATE #{@events_table} SET Location='#{loc}' WHERE ROWID = '#{@rowid}'"
   end
   
   def insert_location(loc)
     @events_table = ENV['event_table']
     return ::FT.execute "INSERT INTO #{@events_table} (Location, event_id) VALUES ('#{loc}', #{id})"
   end
   
   def grab_nearest(number)
     @events_table = ENV['event_table']
     @loc_x = location.split[0].to_f
     @loc_y = location.split[1].to_f
     return ::FT.execute "SELECT * FROM #{@events_table} ORDER BY ST_DISTANCE(Location, LATLNG(#{@loc_x},#{@loc_y})) LIMIT #{number}"
   end
   
end
