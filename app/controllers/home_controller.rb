class HomeController < ApplicationController
    before_action :authenticate_user!
    before_action :set_user, only: [:edit, :update, :destroy]
    def index
        $platform_id = 3
    end

    def show
        if(params[:id] == "iask")
            $platform_id = 0
        elsif(params[:id] == "udn")
            $platform_id = 1
        elsif(params[:id] == "reader")
            $platform_id = 2
        else
            $platform_id = 3 
        end

        redirect_to papers_path
    end

    def management
        @users = User.all.order(:id)
        @role_array = ["SuperAdmin", "Admin", "iAsk", "讀享", "聯合改作文"]
    end

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)

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
    end

    def edit
        @role_array = ["SuperAdmin", "Admin", "iAsk", "讀享", "聯合改作文"]
    end

    def update
        @role_array = ["SuperAdmin", "Admin", "iAsk", "讀享", "聯合改作文"] 
        
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
    
    end

    def destroy
        @user.destroy
         respond_to do |format|
           format.html { redirect_to "/homes/management", notice: '成功刪除使用者' }
           format.json { head :no_content }
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