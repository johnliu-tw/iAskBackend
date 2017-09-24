class WritingQuestionsController < ApplicationController
  before_action :set_writing_question, only: [:show, :edit, :update, :destroy]

  # GET /writing_questions
  # GET /writing_questions.json
  def index
    @writing_questions = WritingQuestion.all
  end

  # GET /writing_questions/1
  # GET /writing_questions/1.json
  def show
  end

  # GET /writing_questions/new
  def new
    @writing_question = WritingQuestion.new
  end

  # GET /writing_questions/1/edit
  def edit
  end

  # POST /writing_questions
  # POST /writing_questions.json
  def create
    @writing_question = WritingQuestion.new(writing_question_params)

    respond_to do |format|
      if @writing_question.save
        format.html { redirect_to @writing_question, notice: 'Writing question was successfully created.' }
        format.json { render :show, status: :created, location: @writing_question }
      else
        format.html { render :new }
        format.json { render json: @writing_question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /writing_questions/1
  # PATCH/PUT /writing_questions/1.json
  def update
    respond_to do |format|
      if @writing_question.update(writing_question_params)
        format.html { redirect_to @writing_question, notice: 'Writing question was successfully updated.' }
        format.json { render :show, status: :ok, location: @writing_question }
      else
        format.html { render :edit }
        format.json { render json: @writing_question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /writing_questions/1
  # DELETE /writing_questions/1.json
  def destroy
    @writing_question.destroy
    respond_to do |format|
      format.html { redirect_to writing_questions_url, notice: 'Writing question was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_writing_question
      @writing_question = WritingQuestion.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def writing_question_params
      params.require(:writing_question).permit(:title, :title_attr, :analysis, :analysis_att, :analysis_url, :active)
    end
end
