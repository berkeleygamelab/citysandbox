class QuestionsController < ApplicationController
  size_limit_questions = 15
  size_limit_discussion = 5
  
  def show
    @questions = Questions.find(:all, :limit => size_limit_questions)
    @discussion_sets = [ ]
    @questions.each {|x| @discussions_sets + Responses.where( :question_id => x.id).limit(5)}
    
end
