class Challenge < ActiveRecord::Base
  has_many :proposals
  has_many :response_challenges
  has_many :followed_challenges
  has_many :events
  
  belongs_to :question
  belongs_to :user
  belongs_to :categories
  
  validates :title, :presence => true
  validates :description, :presence => true
  validates :submission_deadline, :presence => true
  validates :vote_deadline, :presence => true
  
  scope :followed, lambda{|key| {:conditions => {:id => key}}}
  
  scope :has_category,       lambda{ |n| { :conditions => { :categories_id => n}}}
  scope :has_title, lambda{|name| {:conditions => ["title LIKE ? OR title LIKE ? OR title LIKE ?", "% " + name + " %", name, name + " %"]}}


  def category_id
     return categories_id
   end
   
   def create_followed(user)
     followed = FollowedChallenge.new
     followed.user = user
     followed.challenge_id = id
     followed.save
   end


   def fetch_location
     @challenges_table = ENV['challenge_table']
     return ::FT.execute "SELECT Location FROM #{@challenges_table} WHERE challenge_id = #{id}"
   end    

   def update_location(loc)
     @challenges_table = ENV['challenge_table']
     @quest_dummy = ::FT.execute "SELECT rowid FROM #{@challenges_table} WHERE challenge_id = #{id}"
     if @quest_dummy[0] == nil
       return insert_location(loc)
     end
     @rowid = @quest_dummy[0][:rowid]
     
     return ::FT.execute "UPDATE #{@challenges_table} SET Location='#{loc}' WHERE ROWID = '#{@rowid}'"
   end
   
   def insert_location(loc)
     @challenges_table = ENV['challenge_table']
     return ::FT.execute "INSERT INTO #{@challenges_table} (Location, challenge_id) VALUES ('#{loc}', #{id})"
   end
   
   def grab_nearest(number)
     @challenges_table = ENV['challenge_table']
     @loc_x = location.split[0].to_f
     @loc_y = location.split[1].to_f
     return ::FT.execute "SELECT * FROM #{@challenges_table} ORDER BY ST_DISTANCE(Location, LATLNG(#{@loc_x},#{@loc_y})) LIMIT #{number}"
   end
   
end
