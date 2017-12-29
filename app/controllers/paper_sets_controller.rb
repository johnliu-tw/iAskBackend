class PaperSetsController < ApplicationController
  before_action :set_paper_set, only: [:show, :edit, :update, :destroy]

  # GET /paper_sets
  # GET /paper_sets.json
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
      @paper_sets = PaperSet.where(platform_type: 0).order("#{orderParam}  #{order}").paginate(:page => params[:page], :per_page => 10)
    elsif current_user.has_role? :udn
      @paper_sets = PaperSet.where(platform_type: 1).order("#{orderParam}  #{order}").paginate(:page => params[:page], :per_page => 10)    
    elsif current_user.has_role? :reader
      @paper_sets = PaperSet.where(platform_type: 2).order("#{orderParam}  #{order}").paginate(:page => params[:page], :per_page => 10)
    elsif current_user.has_role? :admin
      @paper_sets = PaperSet.where(platform_type: session[:platform_id]).order("#{orderParam}  #{order}").paginate(:page => params[:page], :per_page => 10)
    end
  end

  # GET /paper_sets/1
  # GET /paper_sets/1.json
  def show
  end

  # GET /paper_sets/new
  def new
    @paper_set = PaperSet.new
  end

  # GET /paper_sets/1/edit
  def edit
  end

  # POST /paper_sets
  # POST /paper_sets.json
  def create
    @paper_set = PaperSet.new(paper_set_params)

    respond_to do |format|
      if @paper_set.save
        format.html { redirect_to @paper_set, notice: '成功建立試卷包' }
        format.json { render :show, status: :created, location: @paper_set }
      else
        format.html { render :new }
        format.json { render json: @paper_set.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /paper_sets/1
  # PATCH/PUT /paper_sets/1.json
  def update
    respond_to do |format|
      if @paper_set.update(paper_set_params)
        format.html { redirect_to @paper_set, notice: '成功編輯試卷包' }
        format.json { render :show, status: :ok, location: @paper_set }
      else
        format.html { render :edit }
        format.json { render json: @paper_set.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /paper_sets/1
  # DELETE /paper_sets/1.json
  def destroy
    @paper_set.destroy
    respond_to do |format|
      format.html { redirect_to paper_sets_url, notice: '成功刪除試卷包' }
      format.json { head :no_content }
    end
  end

  def get_paper_sets_by_platform
    @paper_sets = PaperSet.where(:platform_type => params[:platformId], :active => true)
    @paper_sets.each{
      |paper_set| 
      paper_ids = Paper.where(:paper_set_id => paper_set.id).pluck(:id)

      paper_set.assign_attributes({ :paper_ids => paper_ids})
    }

    render json: @paper_sets, methods: [:paper_ids]

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_paper_set
      @paper_set = PaperSet.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def paper_set_params
      params.require(:paper_set).permit(:title, :price, :public_date, :description, :active, :platform_type, :paper_ids)
    end
end
