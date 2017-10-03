class PaperSubjectsController < ApplicationController
  before_action :set_paper_subject, only: [:show, :edit, :update, :destroy]

  # GET /paper_subjects
  # GET /paper_subjects.json
  def index
    @paper_subjects = PaperSubject.paginate(:page => params[:page], :per_page => 5)
  end

  # GET /paper_subjects/1
  # GET /paper_subjects/1.json
  def show
  end

  # GET /paper_subjects/new
  def new
    @paper_subject = PaperSubject.new
  end

  # GET /paper_subjects/1/edit
  def edit
    @subjects = Subject.all
  end

  # POST /paper_subjects
  # POST /paper_subjects.json
  def create
    @paper_subject = PaperSubject.new(paper_subject_params)
    respond_to do |format|
      if @paper_subject.save
        format.html { redirect_to @paper_subject, notice: '成功建立科目' }
        format.json { render :show, status: :created, location: @paper_subject }
      else
        format.html { render :new }
        format.json { render json: @paper_subject.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /paper_subjects/1
  # PATCH/PUT /paper_subjects/1.json
  def update
    respond_to do |format|
      if @paper_subject.update(paper_subject_params)
        format.html { redirect_to @paper_subject, notice: 'Paper subject was successfully updated.' }
        format.json { render :show, status: :ok, location: @paper_subject }
      else
        format.html { render :edit }
        format.json { render json: @paper_subject.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /paper_subjects/1
  # DELETE /paper_subjects/1.json
  def destroy
    @paper_subject.destroy
    respond_to do |format|
      format.html { redirect_to paper_subjects_url, notice: 'Paper subject was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_paper_subject
      @paper_subject = PaperSubject.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def paper_subject_params
      params.require(:paper_subject).permit(:title, :title_view, :active, subject_ids: [],:platform_type)
    end
end
