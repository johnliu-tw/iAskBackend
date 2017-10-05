class GradesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_grade, only: [:show, :edit, :update, :destroy]

  # GET /grades
  # GET /grades.json
  def index
    if current_user.has_role? :iAsk
      @grades = Grade.where(platform_type: 0).paginate(:page => params[:page], :per_page => 5)
    elsif current_user.has_role? :udn
      @grades = Grade.where(platform_type: 1).paginate(:page => params[:page], :per_page => 5)    
    elsif current_user.has_role? :reader
      @grades = Grade.where(platform_type: 2).paginate(:page => params[:page], :per_page => 5)
    elsif current_user.has_role? :admin
      @grades = Grade.where(platform_type: $platform_id).paginate(:page => params[:page], :per_page => 5)
    end
  end

  # GET /grades/1
  # GET /grades/1.json
  def show
  end

  # GET /grades/new
  def new
    @grade = Grade.new
  end

  # GET /grades/1/edit
  def edit
  end

  # POST /grades
  # POST /grades.json
  def create
    @grade = Grade.new(grade_params)
    if current_user.has_role? :iAsk
      @grade.platform_type = 0
    elsif current_user.has_role? :udn
      @grade.platform_type = 1  
    elsif current_user.has_role? :reader
      @grade.platform_type = 2
    elsif current_user.has_role? :admin
      @grade.platform_type = $platform_id
    end

    respond_to do |format|
      if @grade.save
        format.html { redirect_to grades_path, notice: '成功建立新的年級' }
        format.json { render :show, status: :created, location: @grade }
      else
        format.html { render :new }
        format.json { render json: @grade.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /grades/1
  # PATCH/PUT /grades/1.json
  def update
    respond_to do |format|
      if @grade.update(grade_params)
        format.html { redirect_to grades_path, notice: '成功編輯新的年級' }
        format.json { render :show, status: :ok, location: @grade }
      else
        format.html { render :edit }
        format.json { render json: @grade.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /grades/1
  # DELETE /grades/1.json
  def destroy
    @grade.destroy
    respond_to do |format|
      format.html { redirect_to grades_url, notice: '成功刪除以選擇的年級' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_grade
      @grade = Grade.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def grade_params
      params.require(:grade).permit(:name,:platform_type)
    end
end
