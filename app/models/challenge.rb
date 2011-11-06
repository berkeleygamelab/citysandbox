class Challenge < ActiveRecord::Base
  has_many :proposals
  has_many :response_challenges
  has_many :followed_challenges
  has_many :events
  attr_accessor :lat
  attr_accessor :lng
  
  belongs_to :challenge
  belongs_to :user
  belongs_to :categories
  belongs_to :question
  
  validates :categories_id, :presence => true
  validates :title, :presence => true
  validates :description, :presence => true
  validates :submission_deadline, :presence => true
  validates :vote_deadline, :presence => true
  
  scope :followed, lambda{|key| {:conditions => {:id => key}}}
  
  scope :has_category,       lambda{ |n| { :conditions => { :categories_id => n}}}
  scope :has_title, lambda{|name| {:conditions => ["title LIKE ? OR title LIKE ? OR title LIKE ?", "% " + name + " %", name, name + " %"]}}
  scope :keyword, lambda{|key| {:conditions => ["title LIKE ? OR title LIKE ? OR title LIKE ? OR description LIKE ? OR description LIKE ? OR description LIKE ?", "% " + key + " %", key, key + " %", "% " + key + " %", key, key + " %" ]}}


  def category_id
     return categories_id
   end
   def create_followed
     followed = FollowedChallenge.new
     followed.user_id = current_user.id
     followed.challenge_id = id
     
     
     followed.save
   end
   
   def create_followed(follower)
     followed = FollowedChallenge.new
     followed.user_id = follower.id
     followed.challenge_id = id
     if FollowedChallenge.where(:challenge_id => id).where(:user_id => follower.id) == []
       followed.save
     end
   end
   
   def most_popular(since_last)
     return challenge.where("updated_at > '#{since_last}'").where()
   end
   
   def remove_followed
      followed = followed_challenges
      a= followed.where(:user_id => current_user.id).first
      return a.destroy
    end
    
    def remove_followed(follower)
      followed = followed_challenges
      a = followed.where(:user_id => follower.id).first
      return a.destroy
    end

   def fetch_location
     @challenges_table = ENV['csb_locations']
     return ::FT.execute "SELECT Location FROM #{@challenges_table} WHERE id = #{id} AND Origin = 'challenges'"
   end    

   def update_location(loc)
     @challenges_table = ENV['csb_locations']
     @quest_dummy = ::FT.execute "SELECT rowid FROM #{@challenges_table} WHERE id = #{id} AND Origin = 'challenges'"
     if @quest_dummy[0] == nil
       return insert_location(loc)
     end
     @rowid = @quest_dummy[0][:rowid]
     
     return ::FT.execute "UPDATE #{@challenges_table} SET Location='#{loc}' WHERE ROWID = '#{@rowid}' AND Origin = 'challenges'"
   end
   
   def insert_location(loc)
     @challenges_table = ENV['csb_locations']
     return ::FT.execute "INSERT INTO #{@challenges_table} (Location, ID, Origin, Category) VALUES ('#{loc}', #{id}, 'challenges', #{categories_id})"
   end
   
   def grab_nearest(number)
     @challenges_table = ENV['csb_locations']
     @loc_x = location.split[0].to_f
     @loc_y = location.split[1].to_f
     return ::FT.execute "SELECT * FROM #{@challenges_table} WHERE Origin = 'challenge' ORDER BY ST_DISTANCE(Location, LATLNG(#{@loc_x},#{@loc_y})) LIMIT #{number}"
   end
   
   #grabs the nearest locations by distance and location
   def grab_nearest_by_location(distance, loc)
     
   end
   
   def most_popular_proposal
     my_proposals = proposals
     my_counts = -1
     my_popular = []
     my_proposals.each do |x|
       if x.voting_records.size > my_counts
         my_counts = x.voting_records.size
         my_popular = [x.id]
       end
       if x.voting_records.size == my_counts
         my_popular += [x.id]
       end
     end
     return proposals.where(:id => my_popular)
   end
   
    def retrieve_google(db_return)
       rtn = []
       db_return.each do |x|
         rtn += [x[:id]]
       end
       return Challenge.followed(rtn)
     end
   
   
    def most_popular(since_last, distance, target_location)
       google_set = grab_circle(distance, target_location, 25)
       google_fetch = retrieve_google(google_set)
       return google_fetch.where("updated_at > '#{since_last}'").order("popularity DESC")
     end
   
end
