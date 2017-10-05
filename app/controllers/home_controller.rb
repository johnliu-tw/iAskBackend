class HomeController < ApplicationController
    before_action :authenticate_user!
    def index
        $platform_id = 3
    end

    def show
        if(params[:id] == "iask")
            $platform_id = 0
            Rails.logger.debug($platform_id)
        elsif(params[:id] == "udn")
            $platform_id = 1
            Rails.logger.debug($platform_id)
        elsif(params[:id] == "reader")
            $platform_id = 2
            Rails.logger.debug($platform_id)
        else
            $platform_id = 3 
        end

        redirect_to papers_path
    end
end