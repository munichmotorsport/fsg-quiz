class QuizzesController < ApplicationController
  before_action :set_quiz, only: [:show, :edit, :update, :destroy]

  # GET /quizzes
  # GET /quizzes.json
  def index
    @quizzes = Quiz.all
  end

  # GET /quizzes/1
  # GET /quizzes/1.json
  def show
  end

  # GET /quizzes/new
  def new
    @quiz = Quiz.new
  end

  # GET /quizzes/1/edit
  def edit
  end

  # POST /quizzes
  # POST /quizzes.json
  def create
    parbuf = quiz_params
    
    matching_quiz = Quiz.find_by season: parbuf[:season], category: parbuf[:category]
    redirect_to quiz_path(matching_quiz), notice: "This Quiz exists already. Feel free to edit it." and return if matching_quiz
    
    @quiz = Quiz.new(parbuf)

    respond_to do |format|
      # the second argument of this if statement makes sure there are exactly as many correct answers as there are questions - ergo one per one
      if @quiz.save && (Question.where(quiz_id: @quiz.id).count != Answer.where(question_id: Question.where(quiz_id: @quiz.id).to_a.map{|q| q.id}).where(correct: true).count)
        flash.now[:alert] = "Every Question must have exactly one correct answer."
        format.html { render action: 'edit' }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      elsif !@quiz.save
        format.html { render action: 'new' }
        format.json { render json: @quiz.errors, status: :unprocessable_entity }
      else
        format.html { redirect_to @quiz, notice: 'Quiz was successfully created.' }
        format.json { render action: 'show', status: :created, location: @quiz }
      end
    end
  end

  # PATCH/PUT /quizzes/1
  # PATCH/PUT /quizzes/1.json
  def update
    parbuf = quiz_params
    
    matching_quiz = Quiz.find_by season: parbuf[:season], category: parbuf[:category]
    if matching_quiz && matching_quiz.id != @quiz.id
      flash.now[:alert] = "There's another quiz from this season and category."
      render action: 'edit' and return
    end
    
    respond_to do |format|
      # same as in create method for the second argument of the if statement
      if @quiz.update(parbuf) && (Question.where(quiz_id: @quiz.id).count == Answer.where(question_id: Question.where(quiz_id: @quiz.id).to_a.map{|q| q.id}).where(correct: true).count)
        format.html { redirect_to @quiz, notice: 'Quiz was successfully updated.' }
        format.json { head :no_content }
      else
        flash.now[:alert] = "Every Question must have exactly one correct answer."
        format.html { render action: 'edit' }
        format.json { render json: @quiz.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quizzes/1
  # DELETE /quizzes/1.json
  def destroy
    @quiz.destroy
    respond_to do |format|
      format.html { redirect_to quizzes_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quiz
      @quiz = Quiz.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def quiz_params
      params.require(:quiz).permit(
        :season, 
        :category,
        :production_ready, 
        :questions_attributes => [:id, :content, :_destroy, answers_attributes: [:id, :content, :correct, :_destroy]]
      )
    end
end
