class PaperGradeshipsController < ApplicationController
  before_action :set_paper_gradeship, only: [:show, :edit, :update, :destroy]

  # GET /paper_gradeships
  # GET /paper_gradeships.json
  def index
    @paper_gradeships = PaperGradeship.all
  end

  # GET /paper_gradeships/1
  # GET /paper_gradeships/1.json
  def show
  end

  # GET /paper_gradeships/new
  def new
    @paper_gradeship = PaperGradeship.new
  end

  # GET /paper_gradeships/1/edit
  def edit
  end

  # POST /paper_gradeships
  # POST /paper_gradeships.json
  def create
    @paper_gradeship = PaperGradeship.new(paper_gradeship_params)

    respond_to do |format|
      if @paper_gradeship.save
        format.html { redirect_to @paper_gradeship, notice: 'Paper gradeship was successfully created.' }
        format.json { render :show, status: :created, location: @paper_gradeship }
      else
        format.html { render :new }
        format.json { render json: @paper_gradeship.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /paper_gradeships/1
  # PATCH/PUT /paper_gradeships/1.json
  def update
    respond_to do |format|
      if @paper_gradeship.update(paper_gradeship_params)
        format.html { redirect_to @paper_gradeship, notice: 'Paper gradeship was successfully updated.' }
        format.json { render :show, status: :ok, location: @paper_gradeship }
      else
        format.html { render :edit }
        format.json { render json: @paper_gradeship.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /paper_gradeships/1
  # DELETE /paper_gradeships/1.json
  def destroy
    @paper_gradeship.destroy
    respond_to do |format|
      format.html { redirect_to paper_gradeships_url, notice: 'Paper gradeship was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_paper_gradeship
      @paper_gradeship = PaperGradeship.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def paper_gradeship_params
      params.fetch(:paper_gradeship, {})
    end
end
