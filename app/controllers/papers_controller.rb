class PapersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show, :new, :edit, :create, :update, :destroy]
  before_action :set_paper, only: [:show, :edit, :update, :destroy, :copy]
  protect_from_forgery except: :filter

  # GET /papers
  # GET /papers.json
  def index

    if current_user.has_role? :iAsk
      session[:platform_id] = 0
    elsif current_user.has_role? :udn
      session[:platform_id] = 1
    elsif current_user.has_role? :reader
      session[:platform_id] = 2
    end


    if params[:filter] == nil
      orderParam = params[:orderParam]
      order = params[:order]
      
      if orderParam == nil
        orderParam = "id"
      end
      if order == nil
        order = "DESC"
      end

      if params[:relation] == "paper_subjects"
        @papers = Paper.includes(:paper_subject).where(platform_type: session[:platform_id]).order("paper_subjects.title  #{order}").paginate(:page => params[:page], :per_page => 10)
      elsif params[:relation] == "grades"
        @papers = Paper.includes(:grades).where(platform_type: session[:platform_id]).order("grades.name  #{order}").paginate(:page => params[:page], :per_page => 10)
      elsif params[:relation] == "paper_source"
        @papers = Paper.includes(:paper_source).where(platform_type: session[:platform_id]).order("paper_source.name  #{order}").paginate(:page => params[:page], :per_page => 10)
      else
        @papers = Paper.where(platform_type: session[:platform_id]).order("#{orderParam}  #{order}").paginate(:page => params[:page], :per_page => 10)
      end
    else
      @papers = Paper.where(:id => session[:filter_papers_id], :platform_type => session[:platform_id]).paginate(:page => params[:page], :per_page => 10)
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
      @grades = Grade.where(platform_type: session[:platform_id])
    end

    if current_user.has_role? :iAsk
      @paper_subjects = PaperSubject.where(platform_type: 0)
    elsif current_user.has_role? :udn
      @paper_subjects = PaperSubject.where(platform_type: 1) 
    elsif current_user.has_role? :reader
      @paper_subjects = PaperSubject.where(platform_type: 2)
    elsif current_user.has_role? :admin
      @paper_subjects = PaperSubject.where(platform_type: session[:platform_id])
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
      @grades = Grade.where(platform_type: session[:platform_id])
    end

    if current_user.has_role? :iAsk
      @paper_subjects = PaperSubject.where(platform_type: 0)
    elsif current_user.has_role? :udn
      @paper_subjects = PaperSubject.where(platform_type: 1) 
    elsif current_user.has_role? :reader
      @paper_subjects = PaperSubject.where(platform_type: 2)
    elsif current_user.has_role? :admin
      @paper_subjects = PaperSubject.where(platform_type: session[:platform_id])
    end

    if current_user.has_role? :iAsk
      @paper_sources = PaperSource.where(platform_type: 0)
    elsif current_user.has_role? :udn
      @paper_sources = PaperSource.where(platform_type: 1) 
    elsif current_user.has_role? :reader
      @paper_sources = PaperSource.where(platform_type: 2)
    elsif current_user.has_role? :admin
      @paper_sources = PaperSource.where(platform_type: session[:platform_id])
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
      @paper.platform_type = session[:platform_id]
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

  def copy
    @paper.title = "複製_" + @paper.title
  end

  def copy_create
    @paper = Paper.find(params[:id])
    @new_paper = Paper.new(@paper.attributes)
    @new_paper.id = Paper.last.id + 1
    @new_paper.save
    respond_to do |format|
      if @new_paper.update(paper_params)
        format.html { redirect_to papers_path, notice: '成功編輯試卷' }
        format.json { render :show, status: :ok, location: @new_paper }
      else
        format.html { render :edit }
        format.json { render json: @new_paper.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def get_paper_by_platform
    @papers = Paper.select("papers.*, paper_subjects.title_view").joins(:paper_subject).where(:active => true,:platform_type => params[:platformId])
    paper_subject_ids = Paper.distinct(:paper_subject_id).where(:active => true, :platform_type => params[:platformId]).pluck(:paper_subject_id)
    @papers.each{
      |paper| 
      subject_name_list = PaperSubject.find(paper.paper_subject_id).subjects.pluck(:name).join(",")
      correct_rates = StudentCorrectRate.where(:paper_id => paper.id, :student_id => params[:studentId]).pluck(:correct_rate)
      if !correct_rates.present?
        correct_rate = 0
      else
        correct_rate = correct_rates[0].to_i
      end

      question_ids =  Question.where(:paper_id => paper.id, :active => true).where.not(:question_type => "非選").pluck(:id)
      total_q_size = question_ids.size
      log_ids = StudentAnswerLog.where(:question_id => question_ids , :student_id => params[:studentId]).pluck(:question_id)
      answered_size = log_ids.uniq.size

      if total_q_size == 0
        finish_rate = 0
      else
        finish_rate = (answered_size.to_f / total_q_size.to_f)*100
      end


      paper.assign_attributes({ :subject_name => subject_name_list})
      paper.assign_attributes({ :correct_rate => correct_rate})
      paper.assign_attributes({ :finish_rate => finish_rate})      
    }
    render json: @papers, methods: [:subject_name, :correct_rate, :finish_rate]
  end

  def get_papers_by_subject
    paper_subject_ids = PapersubjectSubjectship.where(:subject_id => params[:subjectId]).pluck(:paper_subject_id)
    @papers = Paper.select("papers.*, paper_subjects.title_view").joins(:paper_subject).where(:paper_subject_id => paper_subject_ids, :active => true)
    @papers.each{
      |paper| 
      subject_name_list = PaperSubject.find(paper.paper_subject_id).subjects.pluck(:name).join(",")
      correct_rates = StudentCorrectRate.where(:paper_id => paper.id, :student_id => params[:studentId]).pluck(:correct_rate)
      if !correct_rates.present?
        correct_rate = 0
      else
        correct_rate = correct_rates[0].to_i
      end

      question_ids =  Question.where(:paper_id => paper.id, :active => true).where.not(:question_type => "非選").pluck(:id)
      total_q_size = question_ids.size
      log_ids = StudentAnswerLog.where(:question_id => question_ids , :student_id => params[:studentId]).pluck(:question_id)
      answered_size = log_ids.uniq.size

      if total_q_size == 0
        finish_rate = 0
      else
        finish_rate = (answered_size.to_f / total_q_size.to_f)*100
      end

      paper.assign_attributes({ :subject_name => subject_name_list})
      paper.assign_attributes({ :correct_rate => correct_rate})
      paper.assign_attributes({ :finish_rate => finish_rate})     
    }
    render json: @papers, methods: [:subject_name, :correct_rate]

  end

  def get_papers_by_subject_and_grade
    @papers = Paper.joins(:grades).where("grades.id = #{params[:gradeId]}")
    paper_subject_ids = PapersubjectSubjectship.where(:subject_id => params[:subjectId]).pluck(:paper_subject_id)
    @papers = @papers.select("papers.*, paper_subjects.title_view").joins(:paper_subject).where(:paper_subject_id => paper_subject_ids, :active => true)
    @papers.each{
      |paper| 
      subject_name_list = PaperSubject.find(paper.paper_subject_id).subjects.pluck(:name).join(",")
      correct_rates = StudentCorrectRate.where(:paper_id => paper.id, :student_id => params[:studentId]).pluck(:correct_rate)
      if !correct_rates.present?
        correct_rate = 0
      else
        correct_rate = correct_rates[0].to_i
      end

      question_ids =  Question.where(:paper_id => paper.id, :active => true).where.not(:question_type => "非選").pluck(:id)
      total_q_size = question_ids.size
      log_ids = StudentAnswerLog.where(:question_id => question_ids , :student_id => params[:studentId]).pluck(:question_id)
      answered_size = log_ids.uniq.size

      if total_q_size == 0
        finish_rate = 0
      else
        finish_rate = (answered_size.to_f / total_q_size.to_f)*100
      end

      paper.assign_attributes({ :subject_name => subject_name_list})
      paper.assign_attributes({ :correct_rate => correct_rate})
      paper.assign_attributes({ :finish_rate => finish_rate})     
    }
    render json: @papers, methods: [:subject_name, :correct_rate]
  end


  def get_papers_by_paper_set
    @papers = Paper.select("papers.*, paper_subjects.title_view").joins(:paper_subject).where(:paper_set_id => params[:paperSetId], :active => true)
    @papers.each{
      |paper|
      correct_rates = StudentCorrectRate.where(:paper_id => paper.id, :student_id => params[:studentId]).pluck(:correct_rate)
      if !correct_rates.present?
        correct_rate = 0
      else
        correct_rate = correct_rates[0].to_i
      end


      question_ids =  Question.where(:paper_id => paper.id, :active => true).where.not(:question_type => "非選").pluck(:id)
      total_q_size = question_ids.size
      log_ids = StudentAnswerLog.where(:question_id => question_ids , :student_id => params[:studentId]).pluck(:question_id)
      answered_size = log_ids.uniq.size

      if total_q_size == 0
        finish_rate = 0
      else
        finish_rate = (answered_size.to_f / total_q_size.to_f)*100
      end

      subject_name_list = paper.paper_subject.subjects.pluck(:name).join(",")
      
      paper.assign_attributes({ :correct_rate => correct_rate})
      paper.assign_attributes({ :finish_rate => finish_rate})
      paper.assign_attributes({ :subject_name => subject_name_list})
    }

    render json: @papers, methods: [:finish_rate, :correct_rate, :subject_name]
  end


  def filter
    subject_name = params[:filter][:subject_name]
    grade_name = params[:filter][:grade_name]
    init_public_date = params[:filter][:init_public_date]
    end_public_date = params[:filter][:end_public_date]    
    active = params[:filter][:active]    
    paper_source_name = params[:filter][:paper_source_name]  

    @filter_papers = Paper.all
    if subject_name.present?
      subject_id = Subject.where(:name => subject_name, :platform_type => session[:platform_id]).pluck(:id)
      subject_paper_subject_ids = PapersubjectSubjectship.where(:subject_id => subject_id).pluck(:paper_subject_id)
      @filter_papers = @filter_papers.where(:paper_subject_id => subject_paper_subject_ids)
    end
    if grade_name.present?
      grade_id = Grade.where(:name => grade_name, :platform_type => session[:platform_id]).pluck(:id)
      grade_paper_ids = PaperGradeship.where(:grade_id => grade_id).pluck(:paper_id)
      @filter_papers = @filter_papers.where(:id => grade_paper_ids)
    end
    if paper_source_name.present?
      paper_source_id = PaperSource.where(:name => paper_source_name, :platform_type => session[:platform_id]).pluck(:id)
      @filter_papers = @filter_papers.where(:paper_source_id => paper_source_id)
    end
    if init_public_date.present? && end_public_date.empty?
      @filter_papers = @filter_papers.where("public_date >= '#{init_public_date}'") 
    elsif end_public_date.present? && init_public_date.empty?
      @filter_papers = @filter_papers.where("public_date <= '#{end_public_date}'")
    elsif end_public_date.present? && init_public_date.present?
      @filter_papers = @filter_papers.where("public_date BETWEEN '#{init_public_date}' and '#{end_public_date}'")
    end  
    if active != ""
      active = true?(active)
      @filter_papers = @filter_papers.where(:active => active) 
    end
    session[:filter_papers_id] = @filter_papers.pluck(:id)
    respond_to do |format|
      if params[:filter][:path_name] == "/papers"
        format.html { redirect_to '/papers?filter=true' }
      elsif 
        format.html { redirect_to '/papers/tools/select?filter=true&&id='+params[:filter][:paper_set_id] }
      end
      format.json { render :index, status: :ok, location: @filter_papers }
    end

  end

  def select 

    if params[:id].present?
      @paper_ids = Paper.where.not(:paper_set_id => nil).pluck(:id)
      @public_date = PaperSet.find(params[:id]).public_date
    end

    if params[:filter] == nil
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
          @papers = Paper.includes(:paper_subject).where(platform_type: 0).order("paper_subjects.title #{order}").paginate(:page => params[:page], :per_page => 30)
        elsif current_user.has_role? :udn
          @papers = Paper.includes(:paper_subject).where(platform_type: 1).order("paper_subjects.title #{order}").paginate(:page => params[:page], :per_page => 30)    
        elsif current_user.has_role? :reader
          @papers = Paper.includes(:paper_subject).where(platform_type: 2).order("paper_subjects.title #{order}").paginate(:page => params[:page], :per_page => 30)
        elsif current_user.has_role? :admin
          @papers = Paper.includes(:paper_subject).where(platform_type: session[:platform_id]).order("paper_subjects.title  #{order}").paginate(:page => params[:page], :per_page => 30)
        end
      elsif params[:relation] == "grades"
        if current_user.has_role? :iAsk
          @papers = Paper.includes(:grades).where(platform_type: 0).order("grades.name #{order}").paginate(:page => params[:page], :per_page => 30)
        elsif current_user.has_role? :udn
          @papers = Paper.includes(:grades).where(platform_type: 1).order("grades.name #{order}").paginate(:page => params[:page], :per_page => 30)    
        elsif current_user.has_role? :reader
          @papers = Paper.includes(:grades).where(platform_type: 2).order("grades.name #{order}").paginate(:page => params[:page], :per_page => 30)
        elsif current_user.has_role? :admin
          @papers = Paper.includes(:grades).where(platform_type: session[:platform_id]).order("grades.name  #{order}").paginate(:page => params[:page], :per_page => 30)
        end
      else
        if current_user.has_role? :iAsk
          @papers = Paper.where(platform_type: 0).order("#{orderParam}  #{order}").paginate(:page => params[:page], :per_page => 30)
        elsif current_user.has_role? :udn
          @papers = Paper.where(platform_type: 1).order("#{orderParam}  #{order}").paginate(:page => params[:page], :per_page => 30)    
        elsif current_user.has_role? :reader
          @papers = Paper.where(platform_type: 2).order("#{orderParam}  #{order}").paginate(:page => params[:page], :per_page => 30)
        elsif current_user.has_role? :admin
          @papers = Paper.where(platform_type: session[:platform_id]).order("#{orderParam}  #{order}").paginate(:page => params[:page], :per_page => 30)
        end
      end
    else
      if current_user.has_role? :iAsk
        @papers = Paper.where(:id => session[:filter_papers_id], :platform_type => 0).paginate(:page => params[:page], :per_page => 30)
      elsif current_user.has_role? :udn
        @papers = Paper.where(:id => session[:filter_papers_id], :platform_type => 1).paginate(:page => params[:page], :per_page => 30)
      elsif current_user.has_role? :reader
        @papers = Paper.where(:id => session[:filter_papers_id], :platform_type => 2).paginate(:page => params[:page], :per_page => 30)
      elsif current_user.has_role? :admin
        @papers = Paper.where(:id => session[:filter_papers_id], :platform_type => session[:platform_id]).paginate(:page => params[:page], :per_page => 30)
      end
    end
    @question = Question.new

    render template: "papers/select",layout: false 

  end  

  def show_papers
    @papers = Paper.where(:paper_set_id => params[:id]).paginate(:page => params[:page], :per_page => 10)
    render template: "papers/show_papers",layout: false 
  end




  private
    # Use callbacks to share common setup or constraints between actions.
    def set_paper
      @paper = Paper.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def paper_params
      params.require(:paper).permit(:title, :active, :visible, :public_date, :note, :grade, :open_count, :correct_count,:paper_subject_id,:platform_type,:subject_name,:correct_rate,:paper_source_id, :specific_institution_visible, :specific_institution, grade_ids:[])
    end

    def true?(obj)
      obj.to_s == "true"
    end
end
