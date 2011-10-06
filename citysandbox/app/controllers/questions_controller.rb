class QuestionsController < ApplicationController
  size_limit_questions = 15
  size_limit_discussion = 5
  
  def show
    @Questions = Question.find(:limit => size_limit_questions)
    @Discussion_sets = [ ]
    @Questions.each {|x| @Discussions_sets + Response.find(:limit => size_limit_discussion, :conditions => "title like " + x.id)}
  end
end
