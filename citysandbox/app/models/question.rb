
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
    
    def embedded
    

      # Connect to service    
      @ft = GData::Client::FusionTables.new      
        @ft.clientlogin("ian_norris@berkeley.edu", "norrisi154")

      puts @ft.class
      @table = 1943371
      # 1. SQL interface
      # =========================

      bob = "EMPTY SET"
      bob = @ft.execute "SHOW TABLES"
      puts bob


         ret = @ft.execute "SELECT count() FROM #{@table}"
         puts ret

         sample_poop = @ft.execute "DESCRIBE #{@table}"
         puts sample_poop

          ret = @ft.execute "SELECT ROWID, Text FROM #{@table}"
          puts ret
      end
      

    
    
end
