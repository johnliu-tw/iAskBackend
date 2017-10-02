class PapersController < ApplicationController
  before_action :set_paper, only: [:show, :edit, :update, :destroy]

  # GET /papers
  # GET /papers.json
  def index
    @papers = Paper.paginate(:page => params[:page], :per_page => 5)
    @question = Question.new
  end

  # GET /papers/1
  # GET /papers/1.json
  def show
  end

  # GET /papers/new
  def new
    @paper = Paper.new
    @visibles = [{name: "免費可見"},{name: "購點後可見"},{name: "付費可見"}]
  end

  # GET /papers/1/edit
  def edit
  end

  # POST /papers
  # POST /papers.json
  def create
    @paper = Paper.new(paper_params)

    respond_to do |format|
      if @paper.save
        format.html { redirect_to @paper, notice: 'Paper was successfully created.' }
        format.json { render :show, status: :created, location: @paper }
      else
        format.html { render :new }
        format.json { render json: @paper.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /papers/1
  # PATCH/PUT /papers/1.json
  def update
    respond_to do |format|
      if @paper.update(paper_params)
        format.html { redirect_to @paper, notice: 'Paper was successfully updated.' }
        format.json { render :show, status: :ok, location: @paper }
      else
        format.html { render :edit }
        format.json { render json: @paper.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /papers/1
  # DELETE /papers/1.json
  def destroy
    @paper.destroy
    respond_to do |format|
      format.html { redirect_to papers_url, notice: 'Paper was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_paper
      @paper = Paper.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def paper_params
      params.require(:paper).permit(:title, :active, :visible, :public_date, :note, :grade, :open_count, :correct_count,:paper_subject_id, grade_ids:[])
    end
end
