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
  @collection.sort!{|a,b| a[0].updated_at <=> b[0].updated_at}
  
  
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
  
  if(flag_for_category)
    if(params[:category] == "Event")
    end
  end
  

end

end

