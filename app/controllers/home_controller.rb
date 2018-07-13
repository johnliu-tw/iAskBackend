class HomeController < ApplicationController
    before_action :authenticate_user!, only: [:index, :show, :new, :edit, :create, :update, :destroy, :management]
    before_action :set_user, only: [:edit, :update, :destroy]
    protect_from_forgery except:  [:answer_question_logs, :student_open_paper_log, :student_open_question_log, :student_ask_teacher_question, :answer_question_correct_first, :student_finish_paper ]

    def index
        session[:platform_id] = 3
    end

    def show
        if(params[:id] == "iask")
            session[:platform_id] = 0
        elsif(params[:id] == "udn")
            session[:platform_id] = 1
        elsif(params[:id] == "reader")
            session[:platform_id]  = 2
        else
            session[:platform_id]  = 3 
        end

        redirect_to papers_path
    end

    def management
        if(session[:platform_id]==nil)
            session[:platform_id] = 3
        end
        @users = User.all.order(:id)
        @role_array = ["SuperAdmin", "Admin", "iAsk", "讀享", "聯合改作文"]
        if !current_user.has_role? :admin
            redirect_to papers_path
        end
    end

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if params[:user][:role_ids].include?("leader")
            if (params[:user][:role_ids].include?("iAsk"))||(params[:user][:role_ids].include?("reader"))||(params[:user][:role_ids].include?("udn"))
                respond_to do |format|
                    if @user.save
                        if params[:user][:role_ids].include?("admin")
                            @user.add_role :admin
                            break
                        end
                        if params[:user][:role_ids].include?("iAsk")
                            @user.add_role :iAsk
                        end
                        if params[:user][:role_ids].include?("reader")
                            @user.add_role :reader
                        end
                        if params[:user][:role_ids].include?("udn")
                            @user.add_role :udn
                        end
                        if params[:user][:role_ids].include?("leader")
                            @user.add_role :leader
                        end
                        format.html { redirect_to homes_management_path, notice: '成功建立使用者' }
                        format.json { render :show, status: :created, location: @user }
                    else
                        format.html { render :new }
                        format.json { render json: @user.errors, status: :unprocessable_entity }
                    end
                end
            else
                respond_to do |format|
                    format.html { redirect_to new_home_path, :notice => '未選擇三個平台其中之一' }
                    format.json { render json: @user.errors, status: :unprocessable_entity}   
                end        
            end
        else
            respond_to do |format|
                if @user.save
                    if params[:user][:role_ids].include?("admin")
                        @user.add_role :admin
                    else
                        if params[:user][:role_ids].include?("iAsk")
                            @user.add_role :iAsk
                        end
                        if params[:user][:role_ids].include?("reader")
                            @user.add_role :reader
                        end
                        if params[:user][:role_ids].include?("udn")
                            @user.add_role :udn
                        end
                        if params[:user][:role_ids].include?("leader")
                            @user.add_role :leader
                        end 
                    end
                    format.html { redirect_to homes_management_path, notice: '成功建立使用者' }
                    format.json { render :show, status: :created, location: @user }
                else
                    format.html { render :new }
                    format.json { render json: @user.errors, status: :unprocessable_entity }
                end
            end
        end
    end

    def edit
        @role_array = ["SuperAdmin", "Admin", "iAsk", "讀享", "聯合改作文"]
    end

    def update
        @role_array = ["SuperAdmin", "Admin", "iAsk", "讀享", "聯合改作文"] 
        if params[:user][:role_ids].include?("leader")
            if (params[:user][:role_ids].include?("iAsk"))||(params[:user][:role_ids].include?("reader"))||(params[:user][:role_ids].include?("udn"))
                @user.roles.each do |role|
                    if role.name == "iAsk"
                    @user.remove_role :iAsk
                    end      
                    if role.name == "reader"
                        @user.remove_role :reader
                    end      
                    if role.name == "udn"
                        @user.remove_role :udn
                    end      
                    if role.name == "leader"
                        @user.remove_role :leader
                    end      
                    if role.name == "admin"
                        @user.remove_role :admin
                    end    
                end    

                params[:user][:role_ids].each do |role|  
                    if role == "admin"
                        @user.add_role :admin
                        break
                    end   
                    if role == "iAsk"
                        @user.add_role :iAsk
                    end      
                    if role == "reader"
                        @user.add_role :reader
                    end      
                    if role == "udn"
                        @user.add_role :udn
                    end      
                    if role == "leader"
                        @user.add_role :leader
                    end             
                end
                respond_to do |format|
                    if @user.update(user_params)
                    format.html { redirect_to homes_management_path, notice: '成功編輯使用者' }
                    format.json { render :show, status: :ok, location: @paper }
                    else
                    format.html { render :edit }
                    format.json { render json: @user.errors, status: :unprocessable_entity }
                    end
                end
            else
                respond_to do |format|
                    format.html { redirect_to edit_home_path(@user), :notice => '未選擇三個平台其中之一' }
                    format.json { render json: @user.errors, status: :unprocessable_entity}   
                end  
            end
        else
            respond_to do |format|
                if @user.update(user_params)
                    if params[:user][:role_ids].include?("admin")
                        @user.add_role :admin
                    else
                        if params[:user][:role_ids].include?("iAsk")
                            @user.add_role :iAsk
                        end
                        if params[:user][:role_ids].include?("reader")
                            @user.add_role :reader
                        end
                        if params[:user][:role_ids].include?("udn")
                            @user.add_role :udn
                        end
                        if params[:user][:role_ids].include?("leader")
                            @user.add_role :leader
                        end 
                    end
                    format.html { redirect_to homes_management_path, notice: '成功建立使用者' }
                    format.json { render :show, status: :created, location: @user }
                else
                    format.html { redirect_to edit_home_path(@user) }
                    format.json { render json: @user.errors, status: :unprocessable_entity }
                end
            end            
        end
    end

    def destroy
        @user.destroy
         respond_to do |format|
           format.html { redirect_to "/homes/management", notice: '成功刪除使用者' }
           format.json { head :no_content }
         end
    end

    def answer_question_logs
        @log = StudentAnswerLog.new(:student_id => params[:studentId], :question_id => params[:questionId],
                                :correct => params[:correct], :answer => params[:answer], :answer_count => params[:answerCount])
        result = @log.save!

        if params[:correct]
            @question = Question.find(params[:questionId])
            if @question.answer_count == nil
                @question.answer_count = 1
            else
                @question.answer_count = @question.answer_count + 1
            end
            @question.save!
            question_ids = Question.where(:paper_id => @question.paper_id).where.not(:question_type => "非選").pluck(:id)
            correct_q_size = StudentAnswerLog.where(:student_id => params[:studentId], :correct => true, :question_id => question_ids ).count
            total_q_size = question_ids.size
            correct_rate = (correct_q_size.to_f/total_q_size.to_f)*100

            @correct_log = StudentCorrectRate.where(:student_id => params[:studentId], :paper_id=>@question.paper_id)
            if @correct_log.size > 0
                result = @correct_log.update(:correct_rate => correct_rate)
            else
                @new_log = StudentCorrectRate.new(:student_id => params[:studentId], :paper_id => @question.paper_id, :correct_rate => correct_rate)
                result = @new_log.save!
            end
        end

        respond_to do |format|
            if result
            format.json { render :json => result }
            else
            format.json { render :json => result, :status => 403 }
            end
        end
    end

    def answer_question_correct_first
        question = Question.find(params[:questionId])
        result = question.increment!(:first_correct_count)
        respond_to do |format|
            if result
            format.json { render :json => {:result => true } }
            else
            format.json { render :json => {:result => false }, :status => 403 }
            end
        end
    end

    def student_open_paper_log
        result = StudentOpenPaperLog.create(:paper_id => params[:paperId], :student_id => params[:studentId])
        paper = Paper.find(params[:paperId])
        paper.increment!(:open_count)
        respond_to do |format|
            if result
            format.json { render :json => {:result => true }  }
            else
            format.json { render :json => {:result => false } , :status => 403 }
            end
        end        
    end
    def student_open_question_log
        result = StudentOpenQuestionLog.create(:question_id => params[:questionId], :student_id => params[:studentId])
        respond_to do |format|
            if result
            format.json { render :json => {:result => true, :student_open_question_log_id =>result.id  }  }
            else
            format.json { render :json => {:result => false }, :status => 403 }
            end
        end        
    end

    def student_ask_teacher_question
        result = StudentAskTeacherLog.create(:question_id => params[:questionId], :student_id => params[:studentId], :teacher_id => params[:teacherId], :student_answer => params[:studentAns], :correct => params[:correct])
        respond_to do |format|
            if result
            format.json { render :json => {:result => true }  }
            else
            format.json { render :json => {:result => false }, :status => 403 }
            end
        end        
    end

    def student_finish_paper
        student_correct_rate_log = StudentCorrectRate.where(:student_id => params[:studentId], :paper_id => params[:paperId])
        result = student_correct_rate_log.update(:finished => true, :finished_timestamp => Time.now)
        respond_to do |format|
            if result
            format.json { render :json => {:result => true } }
            else
            format.json { render :json => {:result => false }, :status => 403 }
            end
        end   
    end

    def show_log_api_data

        if params[:logType] == "answer_question_correct_first"
            result = Question.select(:first_correct_count).where(:id => params[:questionId])
        elsif params[:logType] == "student_open_paper_log"
            result = StudentOpenPaperLog.all
        elsif params[:logType] == "student_open_question_log"
            result = StudentOpenQuestionLog.all
        elsif params[:logType] == "student_ask_teacher_question"
            result = StudentAskTeacherLog.all
        elsif params[:logType] == "student_finish_paper"
            result = StudentCorrectRate.select(:finished, :finished_timestamp).where(:student_id => params[:studentId], :paper_id => params[:paperId])
        elsif params[:logType] == "question_answer_count"
            result = StudentAnswerLog.where(:question_id => params[:questionId]).count
        else
            result = false
        end
        respond_to do |format|
            format.json { render :json => result}
        end
                   
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :password)   
    end
end