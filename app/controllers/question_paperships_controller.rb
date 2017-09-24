class QuestionPapershipsController < ApplicationController
  before_action :set_question_papership, only: [:show, :edit, :update, :destroy]

  # GET /question_paperships
  # GET /question_paperships.json
  def index
    @question_paperships = QuestionPapership.all
  end

  # GET /question_paperships/1
  # GET /question_paperships/1.json
  def show
  end

  # GET /question_paperships/new
  def new
    @question_papership = QuestionPapership.new
  end

  # GET /question_paperships/1/edit
  def edit
  end

  # POST /question_paperships
  # POST /question_paperships.json
  def create
    @question_papership = QuestionPapership.new(question_papership_params)

    respond_to do |format|
      if @question_papership.save
        format.html { redirect_to @question_papership, notice: 'Question papership was successfully created.' }
        format.json { render :show, status: :created, location: @question_papership }
      else
        format.html { render :new }
        format.json { render json: @question_papership.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /question_paperships/1
  # PATCH/PUT /question_paperships/1.json
  def update
    respond_to do |format|
      if @question_papership.update(question_papership_params)
        format.html { redirect_to @question_papership, notice: 'Question papership was successfully updated.' }
        format.json { render :show, status: :ok, location: @question_papership }
      else
        format.html { render :edit }
        format.json { render json: @question_papership.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /question_paperships/1
  # DELETE /question_paperships/1.json
  def destroy
    @question_papership.destroy
    respond_to do |format|
      format.html { redirect_to question_paperships_url, notice: 'Question papership was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question_papership
      @question_papership = QuestionPapership.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_papership_params
      params.require(:question_papership).permit(:order)
    end
end
