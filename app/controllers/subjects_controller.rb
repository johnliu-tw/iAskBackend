class SubjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_subject, only: [:show, :edit, :update, :destroy]

  # GET /subjects
  # GET /subjects.json
  def index
    if current_user.has_role? :iAsk
      @subjects = Subject.where(platform_type: 0).paginate(:page => params[:page], :per_page => 5)
    elsif current_user.has_role? :udn
      @subjects = Subject.where(platform_type: 1).paginate(:page => params[:page], :per_page => 5)    
    elsif current_user.has_role? :reader
      @subjects = Subject.where(platform_type: 2).paginate(:page => params[:page], :per_page => 5)
    elsif current_user.has_role? :admin
      @subjects = Subject.where(platform_type: $platform_id).paginate(:page => params[:page], :per_page => 5)
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
