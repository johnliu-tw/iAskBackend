class PaperSourcesController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show, :new, :edit, :create, :update, :destroy]
  before_action :set_paper_source, only: [:show, :edit, :update, :destroy]

  # GET /paper_sources
  # GET /paper_sources.json
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
      if current_user.has_role? :leader
        @paper_sources = PaperSource.where(platform_type: 0).order("#{orderParam}  #{order}").paginate(:page => params[:page], :per_page => 10)
      else
        @paper_sources = PaperSource.where(platform_type: 0, role_id:current_user.roles.last.id).order("#{orderParam}  #{order}").paginate(:page => params[:page], :per_page => 10)
      end
    elsif current_user.has_role? :udn
      @paper_sources = PaperSource.where(platform_type: 1).order("#{orderParam}  #{order}").paginate(:page => params[:page], :per_page => 10)    
    elsif current_user.has_role? :reader
      @paper_sources = PaperSource.where(platform_type: 2).order("#{orderParam}  #{order}").paginate(:page => params[:page], :per_page => 10)
    elsif current_user.has_role? :admin
      @paper_sources = PaperSource.where(platform_type: session[:platform_id]).order("#{orderParam}  #{order}").paginate(:page => params[:page], :per_page => 10)
    end
  end

  # GET /paper_sources/1
  # GET /paper_sources/1.json
  def show
  end

  # GET /paper_sources/new
  def new
    @paper_source = PaperSource.new
  end

  # GET /paper_sources/1/edit
  def edit
  end

  # POST /paper_sources
  # POST /paper_sources.json
  def create
    @paper_source = PaperSource.new(paper_source_params)
    if current_user.has_role? :iAsk
      @paper_source.platform_type = 0
      @paper_source.role_id = current_user.roles.last.id
    elsif current_user.has_role? :udn
      @paper_source.platform_type = 1  
    elsif current_user.has_role? :reader
      @paper_source.platform_type = 2
    elsif current_user.has_role? :admin
      @paper_source.platform_type = session[:platform_id]
    end
    respond_to do |format|
      if @paper_source.save
        format.html { redirect_to paper_sources_path, notice: '成功建立新的試卷來源' }
        format.json { render :show, status: :created, location: @paper_source }
      else
        format.html { render :new }
        format.json { render json: @paper_source.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /paper_sources/1
  # PATCH/PUT /paper_sources/1.json
  def update
    respond_to do |format|
      if @paper_source.update(paper_source_params)
        format.html { redirect_to paper_sources_path, notice: '成功編輯新的試卷來源' }
        format.json { render :show, status: :ok, location: @paper_source }
      else
        format.html { render :edit }
        format.json { render json: @paper_source.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /paper_sources/1
  # DELETE /paper_sources/1.json
  def destroy
    @paper_source.destroy
    respond_to do |format|
      format.html { redirect_to paper_sources_url, notice: '成功刪除已選擇的試卷來源' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_paper_source
      @paper_source = PaperSource.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def paper_source_params
      params.require(:paper_source).permit(:name, :platform_type)
    end
end
