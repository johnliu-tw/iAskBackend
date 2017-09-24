class SelectionQuestionsController < ApplicationController
  before_action :set_selection_question, only: [:show, :edit, :update, :destroy]

  # GET /selection_questions
  # GET /selection_questions.json
  def index
    @selection_questions = SelectionQuestion.all
  end

  # GET /selection_questions/1
  # GET /selection_questions/1.json
  def show
  end

  # GET /selection_questions/new
  def new
    @selection_question = SelectionQuestion.new
  end

  # GET /selection_questions/1/edit
  def edit
  end

  # POST /selection_questions
  # POST /selection_questions.json
  def create
    @selection_question = SelectionQuestion.new(selection_question_params)

    respond_to do |format|
      if @selection_question.save
        format.html { redirect_to @selection_question, notice: 'Selection question was successfully created.' }
        format.json { render :show, status: :created, location: @selection_question }
      else
        format.html { render :new }
        format.json { render json: @selection_question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /selection_questions/1
  # PATCH/PUT /selection_questions/1.json
  def update
    respond_to do |format|
      if @selection_question.update(selection_question_params)
        format.html { redirect_to @selection_question, notice: 'Selection question was successfully updated.' }
        format.json { render :show, status: :ok, location: @selection_question }
      else
        format.html { render :edit }
        format.json { render json: @selection_question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /selection_questions/1
  # DELETE /selection_questions/1.json
  def destroy
    @selection_question.destroy
    respond_to do |format|
      format.html { redirect_to selection_questions_url, notice: 'Selection question was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_selection_question
      @selection_question = SelectionQuestion.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def selection_question_params
      params.require(:selection_question).permit(:title, :title_attr, :answer, :analysis, :analysis_att, :analysis_url, :question_type, :active, :optionCount, :answer_count, :first_correct_count, :questionA, :questionA_attr, :questionB, :questionB_attr, :questionC, :questionC_attr, :questionD, :questionD_attr, :questionE, :questionE_attr, :questionF, :questionF_attr)
    end
end
