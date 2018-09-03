class TeamsController < ApplicationController
    def index 
        @roles = Role.where('id > 6')

        render template: "home/function/team/index"
    end

    def new 
        @team = Role.new
        render template: "home/function/team/new"
    end

    def create
        @team = Role.new(team_params)
    
        respond_to do |format|
          if @team.save
            format.html { redirect_to home_function_team_path, notice: '成功建立新的團隊' }
            format.json { render :show, status: :created, location: @team }
          else
            format.html { render :new }
            format.json { render json: @team.errors, status: :unprocessable_entity }
          end
        end        
    end

    def edit
        @team = Role.find(params[:id])

        render template: "home/function/team/edit"
    end

    def update

        @team = Role.find(params[:id])

        respond_to do |format|
            if @team.update(team_params)
              format.html { redirect_to home_function_team_path, notice: '成功編輯團隊' }
              format.json { render :show, status: :ok, location: @team }
            else
              format.html { render :edit }
              format.json { render json: @team.errors, status: :unprocessable_entity }
            end
          end
    end
    
    def get_team_by_team_id
        team_name = Role.find(params[:id]).name
        respond_to do |format|
            format.json { render :json => {:name => team_name}}
        end
    end

    private

        def team_params
            params.require(:role).permit(:name)
        end
end