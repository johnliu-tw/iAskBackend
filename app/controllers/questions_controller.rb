class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]

  # GET /questions
  # GET /questions.json
  def index
    @questions = Question.paginate(:page => params[:page], :per_page => 5)
    @paper = Paper.find(params[:paper_id])
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
  end

  # GET /questions/new
  def new
    @question = Question.new
    @paper = Paper.find(params[:paper_id])
  end

  # GET /questions/1/edit
  def edit
    @paper = Paper.find(params[:paper_id])
  end

  # POST /questions
  # POST /questions.json
  def create
    @question = Question.new(question_params)

    respond_to do |format|
      if @question.save
        format.html { redirect_to paper_questions_path, notice: 'Selection question was successfully created.' }
        format.json { render :show, status: :created, location: @question }
      else
        format.html { render :new }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to paper_questions_path(question_params[:paper_id],question_params[:id]), notice: 'Selection question was successfully updated.' }
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { render :edit }
        format.json { render json: paper_questions_path.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to paper_questions_path, notice: 'Selection question was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:title, :title_attr, :answer, :analysis, :analysis_att, :analysis_url, :question_type, :active, :optionCount, :answer_count, :first_correct_count, :questionA, :questionA_attr, :questionB, :questionB_attr, :questionC, :questionC_attr, :questionD, :questionD_attr, :questionE, :questionE_attr, :questionF, :questionF_attr, :order,
      :paper_id)
    end
end
