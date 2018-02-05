class PaperSetsController < ApplicationController
  before_action :set_paper_set, only: [:show, :edit, :update, :destroy]
  protect_from_forgery except:[:student_buy_paper_set]
  # GET /paper_sets
  # GET /paper_sets.json
  def index

    platform_type = 0

    if current_user.has_role? :iAsk
      platform_type = 0
    elsif current_user.has_role? :udn
      platform_type = 1
    elsif current_user.has_role? :reader
      platform_type = 2
    elsif current_user.has_role? :admin
      platform_type = session[:platform_id]
    end


    orderParam = params[:orderParam]
    order = params[:order]
    if orderParam == nil
      orderParam = "id"
    end
    if order == nil
      order = "DESC"
    end

    if params[:relation] == "buy_logs"
      @paper_sets = PaperSet.left_joins(:student_buy_logs, :papers).group(:id).where("papers.platform_type = #{platform_type}").order("COUNT(student_buy_logs.id) #{order}")
    else
      @paper_sets = PaperSet.where(platform_type: platform_type).order("#{orderParam}  #{order}").paginate(:page => params[:page], :per_page => 10)
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
    if current_user.has_role? :iAsk
      @paper_set.platform_type = 0
    elsif current_user.has_role? :udn
      @paper_set.platform_type = 1  
    elsif current_user.has_role? :reader
      @paper_set.platform_type = 2
    elsif current_user.has_role? :admin
      @paper_set.platform_type = session[:platform_id]
    end
    
    respond_to do |format|
      if @paper_set.save   
        paper_ids = params[:paper_set][:papers].split(",")
        paper_ids.each{
          |paper_id|
          paper = Paper.find(paper_id)
          paper.update(:paper_set_id => @paper_set.id)
        }
        format.html { redirect_to paper_sets_path, notice: '成功建立試卷包' }
        format.json { render :index, status: :created, location: @paper_set }
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
        paper_ids = params[:paper_set][:papers].split(",")
        paper_ids.each{
          |paper_id|
          paper = Paper.find(paper_id)
          paper.update(:paper_set_id => @paper_set.id)
        }
        format.html { redirect_to paper_sets_path, notice: '成功編輯試卷包' }
        format.json { render :index, status: :ok, location: @paper_set }
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

  def get_paper_sets_by_id
    @paper_set = PaperSet.find(params[:Id])
    paper_ids = Paper.where(:paper_set_id => @paper_set.id).pluck(:id)
    @paper_set.assign_attributes({ :paper_ids => paper_ids})

    render json: @paper_set, methods: [:paper_ids]
  end

  def clear_paper_paper_set_id
    paper_ids =  params[:paperIds]
    @papers = Paper.where(:id => paper_ids)
    @papers.each{
      |paper|
      paper.paper_set_id = nil
      paper.save!
    }

    render json: { result: true}
  end

  def student_buy_paper_set
    if StudentBuyLog.create(:student_id => params[:studentId], :paper_set_id => params[:paperSetId])
      render json: { result: true}
    else
      render json: { result: false}
    end
  end

  def check_paper_bought 
    @paper_set = StudentBuyLog.where(:paper_set_id => params[:paperSetId], :student_id => params[:studentId])  
    if @paper_set.present?
      render json: { bought: true }
    else
      render json: { bought: false }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_paper_set
      @paper_set = PaperSet.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def paper_set_params
      params.require(:paper_set).permit(:title, :price, :public_date, :description, :active, :platform_type, :id, {:papers => []})
    end
end
