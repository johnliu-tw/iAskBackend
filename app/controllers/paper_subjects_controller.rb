class PaperSubjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_paper_subject, only: [:show, :edit, :update, :destroy]

  # GET /paper_subjects
  # GET /paper_subjects.json
  def index
    orderParam = params[:orderParam]
    order = params[:order]
    if orderParam == nil
      orderParam = "id"
    end
    if order == nil
      order = "DESC"
    end
    
    if params[:relation] == "subjects"
      if current_user.has_role? :iAsk
        @paper_subjects = PaperSubject.includes(:subjects).where(platform_type: 0).order("subjects.name #{order}").paginate(:page => params[:page], :per_page => 10)
      elsif current_user.has_role? :udn
        @paper_subjects = PaperSubject.includes(:subjects).where(platform_type: 1).order("subjects.name #{order}").paginate(:page => params[:page], :per_page => 10)    
      elsif current_user.has_role? :reader
        @paper_subjects = PaperSubject.includes(:subjects).where(platform_type: 2).order("subjects.name #{order}").paginate(:page => params[:page], :per_page => 10)
      elsif current_user.has_role? :admin
        @paper_subjects = PaperSubject.includes(:subjects).where(platform_type: $platform_id).order("subjects.name  #{order}").paginate(:page => params[:page], :per_page => 10)
      end
    else  
      if current_user.has_role? :iAsk
        @paper_subjects = PaperSubject.where(platform_type: 0).order("#{orderParam}  #{order}").paginate(:page => params[:page], :per_page => 10)
      elsif current_user.has_role? :udn
        @paper_subjects = PaperSubject.where(platform_type: 1).order("#{orderParam}  #{order}").paginate(:page => params[:page], :per_page => 10)    
      elsif current_user.has_role? :reader
        @paper_subjects = PaperSubject.where(platform_type: 2).order("#{orderParam}  #{order}").paginate(:page => params[:page], :per_page => 10)
      elsif current_user.has_role? :admin
        @paper_subjects = PaperSubject.where(platform_type: $platform_id).order("#{orderParam}  #{order}").paginate(:page => params[:page], :per_page => 10)
      end
    end
  end
  # GET /paper_subjects/1
  # GET /paper_subjects/1.json
  def show
  end

  # GET /paper_subjects/new
  def new
    @paper_subject = PaperSubject.new
    if current_user.has_role? :iAsk
      @subjects = Subject.where(platform_type: 0)
    elsif current_user.has_role? :udn
      @subjects = Subject.where(platform_type: 1) 
    elsif current_user.has_role? :reader
      @subjects = Subject.where(platform_type: 2)
    elsif current_user.has_role? :admin
      @subjects = Subject.where(platform_type: $platform_id)      
    end
  end

  # GET /paper_subjects/1/edit
  def edit
    if current_user.has_role? :iAsk
      @subjects = Subject.where(platform_type: 0)
    elsif current_user.has_role? :udn
      @subjects = Subject.where(platform_type: 1) 
    elsif current_user.has_role? :reader
      @subjects = Subject.where(platform_type: 2)
    elsif current_user.has_role? :admin
      @subjects = Subject.where(platform_type: $platform_id)   
    end
  end

  # POST /paper_subjects
  # POST /paper_subjects.json
  def create
    @paper_subject = PaperSubject.new(paper_subject_params)
    if current_user.has_role? :iAsk
      @paper_subject.platform_type = 0
    elsif current_user.has_role? :udn
      @paper_subject.platform_type = 1  
    elsif current_user.has_role? :reader
      @paper_subject.platform_type = 2
    elsif current_user.has_role? :admin
      @paper_subject.platform_type = $platform_id
    end
    respond_to do |format|
      if @paper_subject.save
        format.html { redirect_to paper_subjects_path, notice: '成功建立試卷科目' }
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
        format.html { redirect_to paper_subjects_path, notice: '成功編輯試卷科目' }
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
      format.html { redirect_to paper_subjects_path, notice: '成功刪除試卷科目' }
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
      params.require(:paper_subject).permit(:title, :title_view, :active,:platform_type, subject_ids: [])
    end
end
