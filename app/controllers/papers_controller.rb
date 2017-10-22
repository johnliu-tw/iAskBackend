class PapersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_paper, only: [:show, :edit, :update, :destroy]

  # GET /papers
  # GET /papers.json
  def index
    orderParam = params[:orderParam]
    order = params[:order]
    
    if orderParam == nil
      orderParam = "id"
    end
    if order == nil
      order = "DESC"
    end

    if params[:relation] == "paper_subjects"
      if current_user.has_role? :iAsk
        @papers = Paper.includes(:paper_subject).where(platform_type: 0).order("paper_subjects.title #{order}").paginate(:page => params[:page], :per_page => 10)
      elsif current_user.has_role? :udn
        @papers = Paper.includes(:paper_subject).where(platform_type: 1).order("paper_subjects.title #{order}").paginate(:page => params[:page], :per_page => 10)    
      elsif current_user.has_role? :reader
        @papers = Paper.includes(:paper_subject).where(platform_type: 2).order("paper_subjects.title #{order}").paginate(:page => params[:page], :per_page => 10)
      elsif current_user.has_role? :admin
        @papers = Paper.includes(:paper_subject).where(platform_type: $platform_id).order("paper_subjects.title  #{order}").paginate(:page => params[:page], :per_page => 10)
      end
    elsif params[:relation] == "grades"
      if current_user.has_role? :iAsk
        @papers = Paper.includes(:grades).where(platform_type: 0).order("grades.name #{order}").paginate(:page => params[:page], :per_page => 10)
      elsif current_user.has_role? :udn
        @papers = Paper.includes(:grades).where(platform_type: 1).order("grades.name #{order}").paginate(:page => params[:page], :per_page => 10)    
      elsif current_user.has_role? :reader
        @papers = Paper.includes(:grades).where(platform_type: 2).order("grades.name #{order}").paginate(:page => params[:page], :per_page => 10)
      elsif current_user.has_role? :admin
        @papers = Paper.includes(:grades).where(platform_type: $platform_id).order("grades.name  #{order}").paginate(:page => params[:page], :per_page => 10)
      end
    else
      if current_user.has_role? :iAsk
        @papers = Paper.where(platform_type: 0).order("#{orderParam}  #{order}").paginate(:page => params[:page], :per_page => 10)
      elsif current_user.has_role? :udn
        @papers = Paper.where(platform_type: 1).order("#{orderParam}  #{order}").paginate(:page => params[:page], :per_page => 10)    
      elsif current_user.has_role? :reader
        @papers = Paper.where(platform_type: 2).order("#{orderParam}  #{order}").paginate(:page => params[:page], :per_page => 10)
      elsif current_user.has_role? :admin
        @papers = Paper.where(platform_type: $platform_id).order("#{orderParam}  #{order}").paginate(:page => params[:page], :per_page => 10)
      end
    end
    @question = Question.new
  end

  # GET /papers/1
  # GET /papers/1.json
  def show
  end

  # GET /papers/new
  def new
    @paper = Paper.new

    if current_user.has_role? :iAsk
      @grades = Grade.where(platform_type: 0)
    elsif current_user.has_role? :udn
      @grades = Grade.where(platform_type: 1) 
    elsif current_user.has_role? :reader
      @grades = Grade.where(platform_type: 2)
    elsif current_user.has_role? :admin
      @grades = Grade.where(platform_type: $platform_id)
    end

    if current_user.has_role? :iAsk
      @paper_subjects = PaperSubject.where(platform_type: 0)
    elsif current_user.has_role? :udn
      @paper_subjects = PaperSubject.where(platform_type: 1) 
    elsif current_user.has_role? :reader
      @paper_subjects = PaperSubject.where(platform_type: 2)
    elsif current_user.has_role? :admin
      @paper_subjects = PaperSubject.where(platform_type: $platform_id)
    end

    @visibles = [{name: "免費可見"},{name: "購點後可見"},{name: "付費可見"}]
  end

  # GET /papers/1/edit
  def edit
    if current_user.has_role? :iAsk
      @grades = Grade.where(platform_type: 0)
    elsif current_user.has_role? :udn
      @grades = Grade.where(platform_type: 1) 
    elsif current_user.has_role? :reader
      @grades = Grade.where(platform_type: 2)
    elsif current_user.has_role? :admin
      @grades = Grade.where(platform_type: $platform_id)
    end

    if current_user.has_role? :iAsk
      @paper_subjects = PaperSubject.where(platform_type: 0)
    elsif current_user.has_role? :udn
      @paper_subjects = PaperSubject.where(platform_type: 1) 
    elsif current_user.has_role? :reader
      @paper_subjects = PaperSubject.where(platform_type: 2)
    elsif current_user.has_role? :admin
      @paper_subjects = PaperSubject.where(platform_type: $platform_id)
    end
  end

  # POST /papers
  # POST /papers.json
  def create
    @paper = Paper.new(paper_params)
    if current_user.has_role? :iAsk
      @paper.platform_type = 0
    elsif current_user.has_role? :udn
      @paper.platform_type = 1  
    elsif current_user.has_role? :reader
      @paper.platform_type = 2
    elsif current_user.has_role? :admin
      @paper.platform_type = $platform_id
    end
    respond_to do |format|
      if @paper.save
        format.html { redirect_to papers_path, notice: '成功建立試卷' }
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
        format.html { redirect_to papers_path, notice: '成功編輯試卷' }
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
      format.html { redirect_to papers_url, notice: '成功刪除試卷' }
      format.json { head :no_content }
    end
  end

  def get_public_date
    @papers = Paper.where(:platform_type => params[:platformId]).pluck(:public_date)
    render @papers
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_paper
      @paper = Paper.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def paper_params
      params.require(:paper).permit(:title, :active, :visible, :public_date, :note, :grade, :open_count, :correct_count,:paper_subject_id,:platform_type,grade_ids:[])
    end
end
