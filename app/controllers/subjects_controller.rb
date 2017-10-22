class SubjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_subject, only: [:show, :edit, :update, :destroy]

  # GET /subjects
  # GET /subjects.json
  def index
    orderParam = params[:orderParam]
    order = params[:order]
    
    if orderParam == nil
      orderParam = "id"
    end
    if order == nil
      order = "DESC"
    end

    if current_user.has_role? :iAsk
      @subjects = Subject.where(platform_type: 0).order("#{orderParam}  #{order}").paginate(:page => params[:page], :per_page => 10)
    elsif current_user.has_role? :udn
      @subjects = Subject.where(platform_type: 1).order("#{orderParam}  #{order}").paginate(:page => params[:page], :per_page => 10)    
    elsif current_user.has_role? :reader
      @subjects = Subject.where(platform_type: 2).order("#{orderParam}  #{order}").paginate(:page => params[:page], :per_page => 10)
    elsif current_user.has_role? :admin
      @subjects = Subject.where(platform_type: $platform_id).order("#{orderParam}  #{order}").paginate(:page => params[:page], :per_page => 10)
    end
  end

  # GET /subjects/1
  # GET /subjects/1.json
  def show
  end

  # GET /subjects/new
  def new
    @subject = Subject.new
  end

  # GET /subjects/1/edit
  def edit
  end

  # POST /subjects
  # POST /subjects.json
  def create
    @subject = Subject.new(subject_params)
    if current_user.has_role? :iAsk
      @subject.platform_type = 0
    elsif current_user.has_role? :udn
      @subject.platform_type = 1  
    elsif current_user.has_role? :reader
      @subject.platform_type = 2
    elsif current_user.has_role? :admin
      @subject.platform_type = $platform_id
    end
    respond_to do |format|
      if @subject.save
        format.html { redirect_to subjects_path, notice: '科目建立成功' }
        format.json { render :show, status: :created, location: @subject }
      else
        format.html { render :new }
        format.json { render json: @subject.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /subjects/1
  # PATCH/PUT /subjects/1.json
  def update
    respond_to do |format|
      if @subject.update(subject_params)
        format.html { redirect_to subjects_path, notice: '科目編輯成功' }
        format.json { render :show, status: :ok, location: @subject }
      else
        format.html { render :edit }
        format.json { render json: @subject.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subjects/1
  # DELETE /subjects/1.json
  def destroy
    @subject.destroy
    respond_to do |format|
      format.html { redirect_to subjects_path, notice: '科目刪除成功' }
      format.json { head :no_content }
    end
  end

  def grade_get_subjects
    paper_ids = Grade.find(params[:grade_id]).paper_ids
    paper_ids.uniq!
    paper_subject_ids = Paper.where(:id => paper_ids).pluck(:paper_subject_id)
    paper_subject_ids.uniq!
    subject_ids = []
    paper_subject_ids.each do |paper_subject_id|
      subject_ids.push(PaperSubject.find( paper_subject_id).subject_ids)
    end
    subject_ids.uniq!
    subject_ids.flatten!
    @subjects = Subject.where(:id => subject_ids)
    render json: @subjects
  end

  def paper_subject_get_subjects
    paper_subject_id = params[:paper_subject_id]
    subject_ids = PaperSubject.find(paper_subject_id).subject_ids
    @subjects = Subject.where(:id => subject_ids)
    render json: @subjects
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subject
      @subject = Subject.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def subject_params
      params.require(:subject).permit(:name,:platform_type)
    end
end
