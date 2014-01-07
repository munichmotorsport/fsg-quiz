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
    parbuf = quiztory_params
    redirect_to "/", alert: 'Please choose a quiz.' and return unless parbuf[:quiz_id]

    parbuf[:user_ids] << current_user.id
    @quiztory = Quiztory.new(parbuf)

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
    # store submitted parameters away
    parbuf = submit_params
    # set attribute "finished" according to the answers received
    parbuf[:finished] = parbuf[:answer_values].all?
    # count false answers so they can be displayed
    false_answers = parbuf[:answer_values].select{|v| not v}.size
    
    respond_to do |format|
      if @quiztory.update(parbuf)
        unless @quiztory.finished
          # here, the failed submits get stored
          @quiztory.failed_submits.merge!({Time.now => current_user.id})
          @quiztory.save
          format.html { redirect_to @quiztory, alert: "#{false_answers} questions have been answered wrongly (or not at all)." }
        end
        format.html { redirect_to @quiztory, notice: "Congrats, you've done it!" }
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
      params.require(:quiztory).permit(:quiz_id, :user_ids => [])
    end
    
    def submit_params
      params["quiztory"]["answer_values"] = params["quiztory"]["answer_values"].values.map do |id|
        if id.to_i == 0
          false
        else
          Answer.find(id).correct
        end 
      end
      
      params.require(:quiztory).permit(:answer_values => [])
    end
end
