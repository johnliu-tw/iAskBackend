class PaperSetBuyAnalyticsController < ApplicationController
  protect_from_forgery except: :filter

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

    if params[:filter] == nil
      orderParam = params[:orderParam]
      order = params[:order]
      # detect order by which parameter
      if orderParam == nil
        orderParam = "id"
      end
      # detect order
      if order == nil
        order = "DESC"
      end
      
      if params[:relation] == "paper_set"
          @buy_logs = StudentBuyLog.left_joins(:paper_set).where("paper_sets.platform_type = #{platform_type}").order("paper_sets.#{params[:attribute]}   #{order}").paginate(:page => params[:page], :per_page => 10)
      elsif params[:relation] == "student"
          @buy_logs = StudentBuyLog.left_joins(:student, :paper_set).where("paper_sets.platform_type = #{platform_type}").order("students.#{params[:attribute]}  #{order}").paginate(:page => params[:page], :per_page => 10)
      elsif params[:relation] == "paper_count"
          @buy_logs = StudentBuyLog.left_joins(:paper_set, :papers).group(:id).where("paper_sets.platform_type = #{platform_type}").order("COUNT(papers.id) #{order}").paginate(:page => params[:page], :per_page => 10)
      else
          @buy_logs = StudentBuyLog.left_joins(:paper_set).where(:paper_sets => {:platform_type => platform_type}).order("#{orderParam}  #{order}").paginate(:page => params[:page], :per_page => 10)
      end
    else
      @buy_logs = StudentBuyLog.left_joins(:paper_set).where(:paper_sets => {:platform_type => platform_type}, :id => session[:filter_log_id]).paginate(:page => params[:page], :per_page => 10)
    end

    respond_to do |format|
      format.html
      format.xls 
    end

  end

  def filter
    years = params[:filter][:years]
    grade = params[:filter][:grade]
    init_public_date = params[:filter][:init_public_date]
    end_public_date = params[:filter][:end_public_date]


    @filter_logs = StudentBuyLog.joins(:student,:paper_set)
    if years.present?
      student_id = Student.where(:years => years).pluck(:id)
      paper_set_ids = PaperSet.where(:platform_type => session[:platform_id]).pluck(:id)     
      @filter_logs = @filter_logs.where(:student_id => student_id, :paper_set_id => paper_set_ids)
    end
    if grade.present?
      grade_id = Student.where(:grade => grade).pluck(:id)
      paper_set_ids = PaperSet.where(:platform_type => session[:platform_id]).pluck(:id)
      @filter_logs = @filter_logs.where(:student_id => grade_id, :paper_set_id => paper_set_ids)
    end
    if init_public_date.present? && end_public_date.empty?
      @filter_logs = @filter_logs.where("paper_sets.public_date >= '#{init_public_date}'")
    elsif end_public_date.present? && init_public_date.empty?
      @filter_logs = @filter_logs.where("paper_sets.public_date <= '#{end_public_date}'")
    elsif end_public_date.present? && init_public_date.present?
      @filter_logs = @filter_logs.where("paper_sets.public_date BETWEEN '#{init_public_date}' and '#{end_public_date}'")
    end
    session[:filter_log_id] = @filter_logs.pluck(:id)

    respond_to do |format|
      format.html { redirect_to '/paper_set_buy_analytics?filter=true' }
      format.json { render :index, status: :ok, location: @filter_logs }
    end

  end

end
