class QuestionsController < ApplicationController
  size_limit_questions = 15
  size_limit_discussion = 5
  page_offset = 1
  
  def show

    @questions = Questions.find(:all, :limit => size_limit_questions)
    @discussion_sets = [ ]
    @questions.each {|x| @discussions_sets = @discussion_sets + Responses.where( :question_id => x.id).limit(5)}
    
  end

  def prefetch
    @questions = Questions.find(:all, :offset => page_offset * size_limit_questions, :limit =>size_limit_questions)
    @discussion_next = []
    @questions.each {|x| @discussions_sets = @discussion_sets + Responses.where (:question_id => x.id).limit(size_limit_discussion)}
    
  end
  
  def filter_by_category
    @questions = Question.where(:category => category_to_sort).limit(size_limit_questions).offset(size_limit_questions*page_offset)
    @discussion_next = []
    @questions.each{|x| @discussion_sets = @discussion_sets + Responses.where(:question_id => x.id).limit(size_limit_discussion)}    
  end
  
  
  def filter_by_set_definition
  end
  

end
