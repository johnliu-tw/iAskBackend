class QuestionsController < ApplicationController
  before_action :authenticate_user! , only: [:index, :show, :new, :edit, :create, :update, :destroy]
  before_action :set_question, only: [:show, :edit, :update, :destroy]

  # GET /questions
  # GET /questions.json
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
      @questions = Question.where(platform_type: 0, paper_id: params[:paper_id]).order("#{orderParam}  #{order}").paginate(:page => params[:page], :per_page => 10)
    elsif current_user.has_role? :udn
      @questions = Question.where(platform_type: 1, paper_id: params[:paper_id]).order("#{orderParam}  #{order}").paginate(:page => params[:page], :per_page => 10)    
    elsif current_user.has_role? :reader
      @questions = Question.where(platform_type: 2, paper_id: params[:paper_id]).order("#{orderParam}  #{order}").paginate(:page => params[:page], :per_page => 10)
    elsif current_user.has_role? :admin
      @questions = Question.where(paper_id: params[:paper_id],platform_type: session[:platform_id]).order("#{orderParam}  #{order}").paginate(:page => params[:page], :per_page => 10)
    end
    
    @paper = Paper.find(params[:paper_id])
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
  end

  # GET /questions/new
  def new
    @question = Question.new
    if current_user.has_role? :iAsk
      @auto_num = Question.where(platform_type: 2, paper_id: params[:paper_id]).size + 1 
    elsif current_user.has_role? :udn
      @auto_num = Question.where(platform_type: 2, paper_id: params[:paper_id]).size + 1 
    elsif current_user.has_role? :reader
      @auto_num = Question.where(platform_type: 2, paper_id: params[:paper_id]).size + 1 
    elsif current_user.has_role? :admin
      @auto_num = Question.where(paper_id: params[:paper_id],platform_type: session[:platform_id]).size + 1 
    end

    @paper = Paper.find(params[:paper_id])
  end

  # GET /questions/1/edit
  def edit
    @paper = Paper.find(params[:paper_id])
  end

  # POST /questions
  # POST /questions.json
  def create
    @question = Question.new(question_params)
    if current_user.has_role? :iAsk
      @question.platform_type = 0
    elsif current_user.has_role? :udn
      @question.platform_type = 1  
    elsif current_user.has_role? :reader
      @question.platform_type = 2
    elsif current_user.has_role? :admin
      @question.platform_type = session[:platform_id]
    end
    respond_to do |format|
      if @question.save
        format.html { redirect_to paper_questions_path, notice: '題目已被成功建立' }
        format.json { render :show, status: :created, location: @question }
      else
        format.html { render :new }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update

    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to paper_questions_path(question_params[:paper_id],question_params[:id]), notice: '題目已被成功編輯' }
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { redirect_to edit_paper_question_path, notice: '上傳檔案大小不可超過500KB' }
        format.json { render json: paper_questions_path.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to paper_questions_path, notice: '題目已被成功刪除' }
      format.json { head :no_content }
    end
  end

  def get_questionList_by_paperId
    @questions = Question.select(:id,:title,:position,:questionA,:questionB,:questionC,:questionD,:questionE,:questionF, :answer).select(get_question_by_questionId).where(:active => true, :paper_id => params[:paperId])
    corrected = false
    @questions.each{
      |question|       
      @answer_logs = StudentAnswerLog.where(:question_id => question.id, :student_id => params[:studentId])
      @answer_logs.each{
        |answer_log|
        if answer_log.correct
          corrected = true
        end
      } 
      answer_count = @answer_logs.size
      if answer_count == 0
        answered = false
      else
        answered = true
      end



      question.assign_attributes({ :answered => answered})
      question.assign_attributes({ :corrected => corrected})
    }

    render json: @questions, methods: [:answered,:corrected],:except => [:analysis_att]
  end

  def get_question_by_questionId
    answer_count = StudentAnswerLog.where(:student_id => params[:studentId],:question_id => params[:questionId]).size
    if answer_count > 0
      @question = Question.select("questions.id,questions.title,questions.question_type,questions.answer,questions.analysis,questions.position,questions.questionA,questions.questionB,questions.questionC,questions.questionD,questions.questionE,questions.questionF,student_answer_logs.answer_count,student_answer_logs.answer as last_answer").select(get_question_file_attr).joins("inner join student_answer_logs on student_answer_logs.question_id = questions.id").where(:id => params[:questionId]).where("student_answer_logs.student_id =?",params[:studentId]).order("student_answer_logs.answer_count DESC").limit(1)
      @question[0].assign_attributes({ :answer_count => answer_count})
      
      render json: @question,  methods: [:answer_count], :except =>  check_empty_question_file_attr(@question)
    else
      @question = Question.select("questions.id,questions.title,questions.question_type,questions.answer,questions.analysis,questions.position,questions.questionA,questions.questionB,questions.questionC,questions.questionD,questions.questionE,questions.questionF").select(get_question_file_attr).where(:id => params[:questionId])
      @question[0].assign_attributes({ :answer_count => 0})

      render json: @question,  methods: [:answer_count], :except =>  check_empty_question_file_attr(@question)   
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    def get_question_file_attr
      return [:title_attr,:questionA_attr,:questionB_attr,:questionC_attr,:questionD_attr,:questionE_attr,:questionF_attr,:analysis_att]
    end

    def check_empty_question_file_attr(question)
      attrList = []
      if question[0].questionE_attr.url == nil 
        attrList.push(:questionE_attr)
      end
      if question[0].questionF_attr.url == nil 
        attrList.push(:questionF_attr)
      end
      return attrList
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:title, :title_attr, :answer, :analysis, :analysis_att, :analysis_url, :question_type, :active, :optionCount, :answer_count, :first_correct_count, :questionA, :questionA_attr, :questionB, :questionB_attr, :questionC, :questionC_attr, :questionD, :questionD_attr, :questionE, :questionE_attr, :questionF, :questionF_attr, :position,
      :paper_id,:platform_type,:remove_title_attr,:remove_questionA_attr,:remove_questionB_attr,:remove_questionC_attr,:remove_questionD_attr,:remove_questionE_attr,:remove_questionF_attr,:remove_analysis_att, :difficulty_degree, :knowledge_point, :answered)
    end
end
