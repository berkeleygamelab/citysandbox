class DiscussionController < ApplicationController

def index
  size_limit_questions = 15
  size_limit_discussion = 5
  page_offset = 0
  @silly = "Wordsssss"
    if params[:false_value] == nil
    @silly = "Sup Nill"
    end
  
  
  @collection = []
  @questions = Question.find(:all, :offset => page_offset * size_limit_questions, :limit =>size_limit_questions)
  @discussion_next = []

  @challenges = Challenge.find(:all, :offset => page_offset * size_limit_questions, :limit => size_limit_questions)
  @events = Event.find(:all, :offset => page_offset * size_limit_questions, :limit => size_limit_questions)
  
  @dummy_set =[]
  @questions.each{|x| @dummy_set = @dummy_set +[[x,x.response_questions.limit(size_limit_discussion)]]}
  @challenges.each{|x| @dummy_set = @dummy_set + [[x,x.response_challenges.limit(size_limit_discussion)]]}
  @events.each{|x| @dummy_set = @dummy_set + [[x, x.response_events.limit(size_limit_discussion)]]}

  
  @collection = @dummy_set
  @collection.sort!{|a,b| b[0].updated_at <=> a[0].updated_at}
  @collection.each{|x| x[1].sort!{|a,b| a.updated_at <=> b.updated_at}}
  
  @collection = self.filter
  
end


def summary
  size_limit_questions = 15
  size_limit_discussion = 5
  page_offset = 0

  
  
  @collection = []
  @questions = Question.find(:all, :offset => page_offset * size_limit_questions, :limit =>size_limit_questions)
  @discussion_next = []

  @challenges = Challenge.find(:all, :offset => page_offset * size_limit_questions, :limit => size_limit_questions)
  @events = Event.find(:all, :offset => page_offset * size_limit_questions, :limit => size_limit_questions)
  
  @dummy_set =[]
  @questions.each{|x| @dummy_set = @dummy_set +[[x,x.response_questions.limit(size_limit_discussion)]]}
  @challenges.each{|x| @dummy_set = @dummy_set + [[x,x.response_challenges.limit(size_limit_discussion)]]}
  @events.each{|x| @dummy_set = @dummy_set + [[x, x.response_events.limit(size_limit_discussion)]]}

  
  @collection = @dummy_set
  @collection.sort!{|a,b| b[0].updated_at <=> a[0].updated_at}
  @collection.each{|x| x[1].sort!{|a,b| a.updated_at <=> b.updated_at}}
  
  @collection = self.filter
  
  if (params[:follow] != nil)
    add_follower(params[:follow], params[:itemz])
  end
  
end



def filter
  size_limit_questions = 15
  size_limit_discussion = 5
  page_offset = 0
  @collection = []
 
  
  @placeholder_set = []
  @flagsorted = false 
  @category_type = params[:category]
  @type_of_stuff = params[:itemz]
  @title = params[:title]
  @timestamp = params[:timeBefore]
    
  @events = Event
  @questions = Question
  @challenges = Challenge
  @followed = params[:followed]
  @followed_type = params[:followed_type]  
  
  
    
    if(@type_of_stuff == nil or @type_of_stuff == "Questions")
      if @followed != nil
        @questions = display_following(@questions, "Question")
        @flagsorted = true
      end
      if @title != nil
        @questions = sort_by_title(@questions, @title)
        @flagsorted = true
      end
      if @category_type != nil
        @questions = sort_by_category(@questions, @category_type)
        @flagsorted = true
      end
      if @timestamp != nil
        @questions = sort_by_timestamp(@questions, @category_type)
        @flagsorted = true
      end


    end
    
    if(@type_of_stuff == nil or @type_of_stuff == "Events")
      if @followed != nil
         @events = display_following(@events, "Event")
         @flagsorted = true
      end
       if @title != nil
         @events = sort_by_title(@events, @title)
         @flagsorted = true
       end
       if @category_type != nil
         @events = sort_by_category(@events, @category_type)
         @flagsorted = true
       end
       if @timestamp != nil
         @events = sort_by_timestamp(@events, @category_type)
         @flagsorted = true
       end

       
   
       
     end
     
     if(@type_of_stuff == nil or @type_of_stuff == "Challenges")
         if @followed != nil
            @challenges = display_following(@challenges, "Challenge")
            @flagsorted = true
         end
        if @title != nil
          @challenges = sort_by_title(@challenges, @title)
          @flagsorted = true
        end
        if @category_type != nil
          @challenges = sort_by_category(@challenges, @category_type)
          @flagsorted = true
        end
        if @timestamp != nil
          @challenges = sort_by_timestamp(@challenges, @category_type)
          @flagsorted = true
        end
      
      end
      
      if(@type_of_stuff == "Questions")
        @challenges = []
        @events = []
      end
      
      if(@type_of_stuff == "Challenges")
        @questions = []
        @events = []
      end
      
      if(@type_of_stuff == "Events")
        @questions = []
        @challenges = []
      end
    
     if @flagsorted == false
       @questions = []
       @challenges = []
       @events = []
       if(@type_of_stuff == "Questions" or @type_of_stuff == nil)
         @questions = Question.find(:all)
       end
       if(@type_of_stuff == "Challenges" or @type_of_stuff == nil)
         @challenges = Challenge.find(:all)
       end
       if(@type_of_stuff == "Events" or @type_of_stuff == nil)
         @events = Event.find(:all)
       end
     end
     
    
      @dummy_set =[]
      @questions.each{|x| @dummy_set = @dummy_set +[[x,x.response_questions.limit(size_limit_discussion)]]}
      @challenges.each{|x| @dummy_set = @dummy_set + [[x,x.response_challenges.limit(size_limit_discussion)]]}
      @events.each{|x| @dummy_set = @dummy_set + [[x, x.response_events.limit(size_limit_discussion)]]}


      @collection = @dummy_set
      @collection.sort!{|a,b| b[0].updated_at <=> a[0].updated_at}
      @collection.each{|x| x[1].sort!{|a,b| a.updated_at <=> b.updated_at}}
      return @collection

end

def sort_by_title(set, title)
  return set.has_title(title)
end

def sort_by_category(set, categoryList)
  
  return set.has_category(categoryList)
end

def sort_by_timestamp(set, timestamp)
  return set.where("updated_at <= ?", timestamp)
end

def sort_by_keyword(set, keyword)
  @statement = "title LIKE '% " + keyword + " %'"
  return set.where(@statement)
end

def add_follower(item_to_follow, type)
  if type == "Question"
    item = Question.where(:id => item_to_follow).first
  end
  if type == "Challenge"
    item = Challenge.where(:id => item_to_follow).first
  end
  if type == "Event"
    item = Event.where(:id => item_to_follow).first
  end
  item.create_followed(current_user)
end

def sort_descending(set)
  return set.order("id desc")
end

def display_following(set, type)
  followed_set_ids = []
  
  if type == "Question"
    followed_set = FollowedQuestion.where(:user_id => current_user.id)
  end
  if type == "Challenge"
    followed_set = FollowedChallenge.where(:user_id => current_user.id)
  end
  if type == "Event"
    followed_set = FollowedEvent.where(:user_id => current_user.id)
  end
  followed_set.each do |value|
    followed_set_ids += [value.followed_id]
  end
  
  return set.followed(followed_set_ids)
    
end




end

