
 class Question < ActiveRecord::Base
  belongs_to :user
  has_many :challenges
  has_many :response_questions
  has_many :events
  has_many :followed_questions
  belongs_to :categories
  
  validates :user_id, :presence => true
  validates :title, :presence => true
  validates :location, :presence => true
  
    scope :has_category,       lambda{ |n| { :conditions => { :categories_id => n}}}
    scope :has_title, lambda{|name| {:conditions => ["title LIKE ? OR title LIKE ? OR title LIKE ?", "% " + name + " %", name, name + " %"]}}

    scope :start_from, lambda{|start| {:conditions => ["id >= ?", start]}}
    scope :keyword_sort, lambda{|key| {:conditions => ["title LIKE ? OR "]}}
    
    scope :followed, lambda{|key| {:conditions => {:id => key}}}
    
    @ft = @ft

        
    def returnThis(stuff)
      return stuff
    end
    
    def category_id
      return categories_id
    end
    
    def create_followed(user)
      followed = FollowedQuestion.new
      followed.user = user
      followed.question_id = id
      followed.save
    end
    
  
    def fetch_location
      @questions_table = ENV['question_table']
      return ::FT.execute "SELECT Location FROM #{@questions_table} WHERE question_id = #{id}"
    end    

    def update_location(loc)
      @questions_table = ENV['question_table']
      @quest_dummy = ::FT.execute "SELECT rowid FROM #{@questions_table} WHERE question_id = #{id}"
      if @quest_dummy[0] == nil
        return insert_location(loc)
      end
      @rowid = @quest_dummy[0][:rowid]
      
      return ::FT.execute "UPDATE #{@questions_table} SET Location='#{loc}' WHERE ROWID = '#{@rowid}'"
    end
    
    def insert_location(loc)
      @questions_table = ENV['question_table']
      return ::FT.execute "INSERT INTO #{@questions_table} (Location, question_id) VALUES ('#{loc}', #{id})"
    end
    
    def grab_nearest(number)
      @questions_table = ENV['question_table']
      @loc_x = location.split[0].to_f
      @loc_y = location.split[1].to_f
      return ::FT.execute "SELECT * FROM #{@questions_table} ORDER BY ST_DISTANCE(Location, LATLNG(#{@loc_x},#{@loc_y})) LIMIT #{number}"
    end
    
end
