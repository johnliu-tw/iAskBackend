class HomeController < ApplicationController
    before_action :authenticate_user!
    before_action :set_user, only: [:edit, :update, :destroy]
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
            correct_q_size = StudentAnswerLog.where(:student_id => params[:studentId], :correct => true ).count
            @question = Question.find(params[:questionId])
            total_q_size = Question.where(:paper_id => @question.paper_id).count
            correct_rate = (correct_q_size/total_q_size)*100

            @correct_log = StudentCorrectRate.where(:student_id => params[:studentId])
            if @correct_log.size > 0
                result = @correct_log.update(:correct_rate => correct_rate)
            else
                @new_log = StudentCorrectRate.new(:student_id => params[:studentId], :paper_id => @question.paper_id, :correct_rate => correct_rate)
                result = @new_log.save!
            end
        end

        respond_to do |format|
            format.json { render :json => result }
            format.xml do
               if result
                 head :ok
               else
                 render :xml => resp, :status => 403 
               end
            end
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