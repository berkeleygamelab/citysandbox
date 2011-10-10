class DiscussionController < ApplicationController



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
  
end

def filter
  size_limit_questions = 15
  size_limit_discussion = 5
  page_offset = 0
  @collection = []
  flag_for_category = nil
  flag_for_type = nil
  flag_for_title = nil
  flag_for_
  if params[:item_type] != null
    flag_for_type = 1
  end
  if params[:title] != null
    flag_for_title = 1
  end
  if params[:category] != null
    flag_for_category = 1
  end
  
  @placeholder_set = []
  @category_type = params[:category]
  @type_of_stuff = "Event"
  @title = params[:title]

    if(@type_of_stuff == "Event")
      if(@category_type == nil)
        if(@title != nil or @title != " ")
          @events = Event.where(:title => @title).offset(page_offset * size_limit_questions).limit(size_limit_questions)
          @events.each{|x| @placeholder_set = @placeholder_set + [[x, x.response_events.limit(size_limit_discussion)]]}
        else
          @events = Event.find(:all, :offset => page_offset * size_limit_questions, :limit => size_limit_questions)
          @events.each{|x| @placeholder_set = @placeholder_set + [[x, x.response_events.limit(size_limit_discussion)]]}
        end
      else  
        if(@title != nil or @title != " ")
            @events = Event.where(:title => @title).offset(page_offset * size_limit_questions).limit(size_limit_questions)
            @events.each{|x| @placeholder_set = @placeholder_set + [[x, x.response_events.limit(size_limit_discussion)]]}
        else
            @events = Event.find(:all, :offset => page_offset * size_limit_questions, :limit => size_limit_questions)
            @events.each{|x| @placeholder_set = @placeholder_set + [[x, x.response_events.limit(size_limit_discussion)]]}
        end
      end
    end
    if(@type_of_stuff == "Challenge")
      if(@category_type == nil)
        if(@title != nil or @title != " ")
          @events = Challenge.where(:title => @title).offset(page_offset * size_limit_questions).limit(size_limit_questions)
          @events.each{|x| @placeholder_set = @placeholder_set + [[x, x.response_challenge.limit(size_limit_discussion)]]}
        else
          @events = Challenge.find(:all, :offset => page_offset * size_limit_questions, :limit => size_limit_questions)
          @events.each{|x| @placeholder_set = @placeholder_set + [[x, x.response_challenge.limit(size_limit_discussion)]]}
        end
      else  
        if(@title != nil or @title != " ")
            @events = Challenge.where(:title => @title).offset(page_offset * size_limit_questions).limit(size_limit_questions)
            @events.each{|x| @placeholder_set = @placeholder_set + [[x, x.response_challenge.limit(size_limit_discussion)]]}
        else
            @events = Challenge.find(:all, :offset => page_offset * size_limit_questions, :limit => size_limit_questions)
            @events.each{|x| @placeholder_set = @placeholder_set + [[x, x.response_challenge.limit(size_limit_discussion)]]}
        end
      end
    end
    if(@type_of_stuff == "Question")
      if(@category_type == nil)
        if(@title != nil or @title != " ")
          @events = Question.where(:title => @title).offset(page_offset * size_limit_questions).limit(size_limit_questions)
          @events.each{|x| @placeholder_set = @placeholder_set + [[x, x.responses.limit(size_limit_discussion)]]}
        else
          @events = Question.find(:all, :offset => page_offset * size_limit_questions, :limit => size_limit_questions)
          @events.each{|x| @placeholder_set = @placeholder_set + [[x, x.responses.limit(size_limit_discussion)]]}
        end
      else  
        if(@title != nil or @title != " ")
            @events = Question.where(:title => @title).offset(page_offset * size_limit_questions).limit(size_limit_questions)
            @events.each{|x| @placeholder_set = @placeholder_set + [[x, x.responses.limit(size_limit_discussion)]]}
        else
            @events = Question.find(:all, :offset => page_offset * size_limit_questions, :limit => size_limit_questions)
            @events.each{|x| @placeholder_set = @placeholder_set + [[x, x.responses.limit(size_limit_discussion)]]}
        end
      end
    end
  
  @placeholder.sort!{|a,b| a[0].updated_at <=> b[0].updated_at}
  
  

end

end


