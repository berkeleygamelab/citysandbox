
 class Question < ActiveRecord::Base
  belongs_to :user
  has_many :challenges
  has_many :response_questions
  has_many :events
  has_many :followed_questions
  belongs_to :categories
  attr_accessor :lat
  attr_accessor :lng
  
  validates :user_id, :presence => true
  validates :title, :presence => true
  validates :location, :presence => true
  validates :categories_id, :presence => true
  
  
  
    scope :has_category,       lambda{ |n| { :conditions => { :categories_id => n}}}
    scope :has_title, lambda{|name| {:conditions => ["title LIKE ? OR title LIKE ? OR title LIKE ?", "% " + name + " %", name, name + " %"]}}

    scope :start_from, lambda{|start| {:conditions => ["id >= ?", start]}}
    scope :keyword_sort, lambda{|key| {:conditions => ["title LIKE ? OR "]}}
    
    scope :followed, lambda{|key| {:conditions => {:id => key}}}
    
    scope :recent_than, lambda{|key| {:conditions => ["updated_at > ?", key]}}
    scope :order_by_followed, {:order => "id IN (SELECT COUNT(*) FROM 'followed_questions' WHERE 'followed_questions'.'question_id' = id)"}
    
    scope :popularity_contest, {:order => "id IN (SELECT COUNT(*) FROM 'followed_questions' WHERE 'followed_questions'.'question_id' = id) + id IN (SELECT COUNT(*) FROM 'response_questions' WHERE 'response_questions'.'question_id' = id)"}
    
    scope :response_contest, {:order => "id IN (SELECT COUNT(*) FROM 'response_questions' WHERE 'response_questions'.'question_id' = id)"}
    
    scope :keyword, lambda{|key| {:conditions => ["title LIKE ? OR title LIKE ? OR title LIKE ? OR description LIKE ? OR description LIKE ? OR description LIKE ?", "% " + key + " %", key, key + " %", "% " + key + " %", key, key + " %" ]}}
    
    
    
    @ft = @ft

    def insert_driver
      
    end
    
    
    
    
    def sift_keyword(key)
      sift = ResponseQuestion.where("response LIKE ? OR response LIKE ? OR response LIKE ?", "% " + key + " %", key, key + " %")
      set = []
      sift.each do |resp|
        set += [resp.question_id]
      end
      sift1 = ResponseQuestion.where(:id => set)
      
    end

    def before_create
      puts "derp"
    end
        
    def returnThis(stuff)
      return stuff
    end
    
    def category_id
      return categories_id
    end
    
    def create_followed
      followed = FollowedQuestion.new
      followed.user_id = current_user.id
      followed.question_id = id
      
      
      followed.save
    end
    
    def create_followed(follower)
      followed = FollowedQuestion.new
      followed.user_id = follower.id
      followed.question_id = id
      if FollowedQuestion.where(:question_id => id).where(:user_id => follower.id) == []
        followed.save
      end
    end
    
   
    
    def remove_followed
       followed = followed_questions
       a= followed.where(:user_id => current_user.id).first
       return a.destroy
    end
     
     def remove_followed(follower)
       followed = followed_questions
       a = followed.where(:user_id => follower.id).first
       return a.destroy
     end
  
    def fetch_location
      @questions_table = ENV['csb_locations']
      return ::FT.execute "SELECT Location FROM #{@questions_table} WHERE ID = #{id} AND Origin = 'questions'"
    end    

    def update_location(loc)
      @questions_table = ENV['csb_locations']
      @quest_dummy = ::FT.execute "SELECT rowid FROM #{@questions_table} WHERE ID = #{id} AND Origin = 'questions'"
      if @quest_dummy[0] == nil
        return insert_location(loc)
      end
      @rowid = @quest_dummy[0][:rowid]
      
      return ::FT.execute "UPDATE #{@questions_table} SET Location='#{loc}' WHERE ROWID = '#{@rowid}' AND Origin = 'questions'"
    end
    
    def insert_location(loc)
      @questions_table = ENV['csb_locations']
      return ::FT.execute "INSERT INTO #{@questions_table} (Location, ID, Origin, Category) VALUES ('#{loc}', #{id}, 'questions', #{categories_id}) "
    end
    
    def grab_nearest(number)
      @questions_table = ENV['csb_locations']
      @loc_x = location.split[0].to_f
      @loc_y = location.split[1].to_f
      return ::FT.execute "SELECT * FROM #{@questions_table} WHERE Origin = 'questions' ORDER BY ST_DISTANCE(Location, LATLNG(#{@loc_x},#{@loc_y})) LIMIT #{number}"
    end
    
    def grab_circle(distance, target_loc, number)
      @questions_table = ENV['csb_locations']
      @loc_x = target_loc.split[0].to_f
      @loc_y = target_loc.split[1].to_f
      puts distance
      return ::FT.execute "SELECT * FROM #{@questions_table} WHERE ST_INTERSECTS(Location, CIRCLE(LATLNG(#{@loc_x}, #{@loc_y}), #{distance})) AND Origin = 'questions'"
    end
    
    def sift_circle(distance, target_loc, number, set)
      circles = grab_circle(distance, target_loc, number)
      circles = retrieve_google_with_set(set, circles)
      return circles
    end
    
    def retrieve_google_with_set(set, db_return)
      rtn = []
      db_return.each do |x|
        rtn += [x[:id]]
      end
      return set.followed(rtn)
    end
    
    def grab_rectangle(upper_right, lower_left)
      @questions_table = ENV['question_table']
      @upper_right_x = upper_right.split[0].to_f
      @upper_right_y = upper_right.split[1].to_f
      @lower_left_x = lower_left.split[0].to_f
      @lower_left_y = lower_left.split[1].to_f
      return ::FT.execute "SELECT * FROM #{@questions_table} WHERE ST_INTERSECTS(Location, RECTANGLE(LATLNG(#{@upper_right_x}, #{@upper_right_y}), LATLNG(#{@lower_left_x}, #{@lower_left_y}))) AND Origin = 'questions'"
    end
    
    def retrieve_entries(db_return)
      rtn = []
      db_return.each do |x|
        rtn += [x["id"]]
      end
      return Question.followed(rtn)
    end
    
    
    
    def combine_google_filter(db_return, set)
      return set.where(:id => db_return)
    end
    
    def retrieve_google(db_return)
      rtn = []
      db_return.each do |x|
        rtn += [x[:id]]
      end
      return Question.followed(rtn)
    end
    
    def playing_with_interface(location)
      
      @questions_table = ENV['question_table']
      return 
    end
    
    
     def most_popular(since_last, distance, target_location)
        set =  Question.where("updated_at > '#{since_last}'").order("popularity DESC")
        google_set = grab_circle(distance, target_location, 25)
        google_fetch = retrieve_google(google_set)
        return google_fetch.where("updated_at > '#{since_last}'").order("popularity DESC")
      end
      
end

