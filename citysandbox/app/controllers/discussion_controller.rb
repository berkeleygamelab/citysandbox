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
  @questions.each{|x| @dummy_set = @dummy_set +[[x,x.responses.limit(size_limit_discussion)]]}
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
  @silly = "Wordsssss"
    if params[:false_value] == nil
    @silly = "Sup Biznatches"
    end
  
  
  @collection = []
  @questions = Question.find(:all, :offset => page_offset * size_limit_questions, :limit =>size_limit_questions)
  @discussion_next = []

  @challenges = Challenge.find(:all, :offset => page_offset * size_limit_questions, :limit => size_limit_questions)
  @events = Event.find(:all, :offset => page_offset * size_limit_questions, :limit => size_limit_questions)
  
  @dummy_set =[]
  @questions.each{|x| @dummy_set = @dummy_set +[[x,x.responses.limit(size_limit_discussion)]]}
  @challenges.each{|x| @dummy_set = @dummy_set + [[x,x.response_challenges.limit(size_limit_discussion)]]}
  @events.each{|x| @dummy_set = @dummy_set + [[x, x.response_events.limit(size_limit_discussion)]]}

  
  @collection = @dummy_set
  @collection.sort!{|a,b| b[0].updated_at <=> a[0].updated_at}
  @collection.each{|x| x[1].sort!{|a,b| a.updated_at <=> b.updated_at}}
  
  @collection = self.filter
  
end

def filter
  size_limit_questions = 15
  size_limit_discussion = 5
  page_offset = 0
  @collection = []
  flag_for_category = nil
  flag_for_type = nil
  flag_for_title = nil
 
  if params[:item_type] != nil
    flag_for_type = 1
  end
  if params[:title] != nil
    flag_for_title = 1
  end
  if params[:category] != nil
    flag_for_category = 1
  end
  
  @placeholder_set = []
  @flagsorted = false 
  @category_type = params[:category]
  @type_of_stuff = params[:itemz]
  @title = params[:title]
  @timestamp = params[:timeBefore]
    
  @events = Event
  @questions = Question
  @challenges = Challenge
    
    
    if(@type_of_stuff == nil or @type_of_stuff == "Questions")
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
    
     if @flagsorted == false
       @questions = Question.find(:all)
       @challenges = Challenge.find(:all)
       @events = Event.find(:all)
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
  @statement = "title LIKE '% " + title + " %'"
  return set.where(@statement) 
end

def sort_by_category(set, categoryList)
  @temp = set
  @temp_many = []
  categoryList.each do |x|
    @statement = "category LIKE '" + x + "'"
    @temp = @temp.where(@statement)
    @temp_many = @temp_many + @temp
  end
  return @temp_many
end

def sort_by_timestamp(set, timestamp)
  return set.where("updated_at <= ?", timestamp)
end

def sort_by_keyword(set, keyword)
  @statement = "title LIKE '% " + keyword + " %'"
  return set.where(@statement)
end

def add_follower(item_to_follow, item)
end


end

