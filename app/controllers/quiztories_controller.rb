class QuiztoriesController < ApplicationController
  before_action :set_quiztory, only: [:show, :edit, :update, :destroy]

  # GET /quiztories
  # GET /quiztories.json
  def index
    @quiztories = Quiztory.all
  end

  # GET /quiztories/1
  # GET /quiztories/1.json
  def show
  end

  # GET /quiztories/new
  def new
    @quiztory = Quiztory.new
  end

  # GET /quiztories/1/edit
  def edit
  end

  # POST /quiztories
  # POST /quiztories.json
  def create
    @quiztory = Quiztory.new(quiztory_params)
    
    @quiztory.users << current_user
    @quiztory.answer_values = Array.new(@quiztory.questions.count.times,false)

    respond_to do |format|
      if @quiztory.save
        format.html { redirect_to @quiztory, notice: 'Go go go!' }
        format.json { render action: 'show', status: :created, location: @quiztory }
      else
        format.html { render action: 'new' }
        format.json { render json: @quiztory.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /quiztories/1
  # PATCH/PUT /quiztories/1.json
  def update
    parbuf = quiztory_params
    parbuf[:finished] = parbuf[:answer_values].all? { |value| value == "true" }
    false_answers = parbuf[:answer_values].select{|v| not v}.size
    
    respond_to do |format|
      if @quiztory.update(parbuf)
        format.html { redirect_to @quiztory, alert: "#{false_answers} questions have been answered wrongly (or not at all)." unless @quiztory.finished }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @quiztory.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quiztories/1
  # DELETE /quiztories/1.json
  def destroy
    @quiztory.destroy
    respond_to do |format|
      format.html { redirect_to quiztories_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quiztory
      @quiztory = Quiztory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def quiztory_params
      params["quiztory"]["answer_values"] = params["quiztory"]["answer_values"].values.map do |id|
        if id.to_i == 0
          false
        else
          Answer.find(id).correct
        end 
      end
      
      params.require(:quiztory).permit(
        :failed_submits, 
        :quiz_id,
        :answer_values => []
      )
    end
end
