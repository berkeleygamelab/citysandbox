class UsersController < ApplicationController
  def index
    @questions = Question.find(:all)
  end
end
