class QuestionsController < ApplicationController

  size_limit_questions = 15
  size_limit_discussion = 5
  page_offset = 1


  # GET /questions/1
  # GET /questions/1.json
  def show
    @question = Question.where(:id => params[:id])[0]
    @category = Categories.find(@question.category_id)
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @question }
    end
  end

  # GET /questions/new
  # GET /questions/new.json
  def new
    @question = Question.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @question }
    end
  end

  # GET /questions/1/edit
  def edit
    @question = Question.find(params[:id])
  end

  # POST /questions
  # POST /questions.json
  def create
    @question = Question.new(params[:question])
    @question.user = current_user
    
    respond_to do |format|
      if @question.save
        @question.insert_location(@question.lat + ', ' + @question.lng)
        format.html { redirect_to @question, notice: 'Question was successfully created.' }
        format.json { render json: @question, status: :created, location: @question }
      else
        format.html { render action: "new" }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /questions/1
  # PUT /questions/1.json
  def update
    @question = Question.find(params[:id])

    respond_to do |format|
      if @question.update_attributes(params[:question])
        format.html { redirect_to @question, notice: 'Question was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question = Question.find(params[:id])
    @question.destroy

    respond_to do |format|
      format.html { redirect_to questions_url }
      format.json { head :ok }
    end
  end


  def prefetch
    size_limit_questions = 15
    size_limit_discussion = 5
    page_offset = 1
    @questions = Question.find(:all, :offset => page_offset * size_limit_questions, :limit =>size_limit_questions)
    @discussion_next = []
    @questions.each {|x|  @discussion_next = @discussion_next + [ResponseQuestion.where(:question_id => x.id).limit(size_limit_discussion)]}
    
  end
  
  def filter_by_category
    @questions = Question.where(:category => category_to_sort).limit(size_limit_questions).offset(size_limit_questions*page_offset)
    @discussion_next = []
    @questions.each{|x| @discussion_sets = @discussion_sets + ResponseQuestion.where(:question_id => x.id).limit(size_limit_discussion)}    
  end
  
  
  def filter_by_set_definition
  end
  

end
