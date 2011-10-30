class DiscussionController < ApplicationController

respond_to :json

def summary
  size_limit_questions = 15
  size_limit_discussion = 5
  page_offset = 0

  if (params[:follow] != nil)
      add_follower(params[:follow], params[:itemz])
  elsif (params[:unfollow] != nil) 
      remove_follower(params[:unfollow], params[:itemz])
  end

  @collection = []
  @questions = Question.find(:all, :offset => page_offset * size_limit_questions, :limit =>size_limit_questions)
  @challenges = Challenge.find(:all, :offset => page_offset * size_limit_questions, :limit => size_limit_questions)
  @events = Event.find(:all, :offset => page_offset * size_limit_questions, :limit => size_limit_questions)

  @questions.each{|x| @collection = @collection +[[x,x.response_questions.limit(size_limit_discussion)]]}
  @challenges.each{|x| @collection = @collection + [[x,x.response_challenges.limit(size_limit_discussion)]]}
  @events.each{|x| @collection = @collection + [[x, x.response_events.limit(size_limit_discussion)]]}

  @collection.sort!{|a,b| b[0].updated_at <=> a[0].updated_at}
  @collection.each{|x| x[1].sort!{|a,b| a.updated_at <=> b.updated_at}}
  
  return(@collection)
end

def filter  
  size_limit_questions = 15
  size_limit_discussion = 5
  page_offset = 0
  @collection = []
 
  @flagsorted = false 
  @category_type = params[:category]
  @type_of_stuff = params[:types]
  @title = params[:title]
  @timestamp = params[:timeBefore]
    
  @events = Event
  @questions = Question
  @challenges = Challenge
  @followed = params[:followed]
  @followed_type = params[:followed_type]  
      
    if (@type_of_stuff == nil or @type_of_stuff.find_index("Questions") != nil)
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
    
    if (@type_of_stuff == nil or @type_of_stuff.find_index("Events") != nil)
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
     
     if(@type_of_stuff == nil or@type_of_stuff.find_index("Challenges") != nil)
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
  
     if @flagsorted == false
       @questions = []
       @challenges = []
       @events = []
       if(@type_of_stuff.find_index("Questions") != nil or @type_of_stuff == nil)
         @questions = Question.find(:all)
       end
       if(@type_of_stuff.find_index("Challenges") != nil  or @type_of_stuff == nil)
         @challenges = Challenge.find(:all)
       end
       if(@type_of_stuff.find_index("Events") != nil  or @type_of_stuff == nil)
         @events = Event.find(:all)
       end
     end
     
    
      @collection = []
      @questions.each{|x| @collection = @collection +[[x,x.response_questions.limit(size_limit_discussion)]]}
      @challenges.each{|x| @collection = @collection + [[x,x.response_challenges.limit(size_limit_discussion)]]}
      @events.each{|x| @collection = @collection + [[x, x.response_events.limit(size_limit_discussion)]]}

      @collection.sort!{|a,b| b[0].updated_at <=> a[0].updated_at}
      @collection.each{|x| x[1].sort!{|a,b| a.updated_at <=> b.updated_at}}

      respond_with(@collection)

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
  
  redirect_to summary_path
end

def remove_follower(item_to_follow, type)
    if type == "Question"
      item = Question.where(:id => item_to_follow).first
    end
    if type == "Challenge"
      item = Challenge.where(:id => item_to_follow).first
    end
    if type == "Event"
      item = Event.where(:id => item_to_follow).first
    end
    item.remove_followed(current_user)
    
      redirect_to summary_path
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

