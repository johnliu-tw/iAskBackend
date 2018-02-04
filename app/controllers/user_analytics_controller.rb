class UserAnalyticsController < ApplicationController

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
      
      if params[:relation] == "paper_subjects"
          @student_paper_logs = StudentPaperLog.left_joins(:paper_subject, :paper).where("papers.platform_type = #{platform_type}").order("paper_subjects.title  #{order}").paginate(:page => params[:page], :per_page => 10)
      elsif params[:relation] == "student"
          @student_paper_logs = StudentPaperLog.left_joins(:student, :paper).where("papers.platform_type = #{platform_type}").order("students.#{params[:attribute]}  #{order}").paginate(:page => params[:page], :per_page => 10)
      elsif params[:relation] == "questions"
          @student_paper_logs = StudentPaperLog.left_joins(:questions, :paper).group(:id).where("papers.platform_type = #{platform_type}").order("COUNT(questions.id) #{order}").paginate(:page => params[:page], :per_page => 10)
      elsif params[:relation] == "paper"
          @student_paper_logs = StudentPaperLog.left_joins(:paper).where("papers.platform_type = #{platform_type}").order("papers.#{params[:attribute]}  #{order}").paginate(:page => params[:page], :per_page => 10)
      else
          @student_paper_logs = StudentPaperLog.left_joins(:paper).where("papers.platform_type = #{platform_type}").order("#{orderParam}  #{order}").paginate(:page => params[:page], :per_page => 10)
      end
    else
      @student_paper_logs = StudentPaperLog.left_joins(:paper).where("papers.platform_type = #{platform_type} and student_paper_logs.id = #{session[:filter_log_id]}").paginate(:page => params[:page], :per_page => 10)
    end

  end

  def filter
    subject_name = params[:filter][:subject_name]
    grade = params[:filter][:grade]
    init_public_date = params[:filter][:init_public_date]
    end_public_date = params[:filter][:end_public_date]
    years = params[:filter][:years]


    @filter_logs = StudentPaperLog.left_joins(:paper)
    if subject_name.present?
      subject_id = Subject.where(:name => subject_name, :platform_type => session[:platform_id]).pluck(:id)
      subject_paper_subject_ids = PapersubjectSubjectship.where(:subject_id => subject_id).pluck(:paper_subject_id)
      @filter_logs = @filter_logs.where("papers.paper_subject_id = #{subject_paper_subject_ids}")
    end
    if grade.present?
      grade_id = Grade.where(:name => grade, :platform_type => session[:platform_id]).pluck(:id)
      grade_paper_ids = PaperGradeship.where(:grade_id => grade_id).pluck(:paper_id)
      @filter_logs = @filter_logs.where("papers.id = #{grade_paper_ids}")
    end
    if init_public_date.present? && end_public_date.empty?
      @filter_logs = @filter_logs.where("papers.public_date >= '#{init_public_date}'")
    elsif end_public_date.present? && init_public_date.empty?
      @filter_logs = @filter_logs.where("papers.public_date <= '#{end_public_date}'")
    elsif end_public_date.present? && init_public_date.present?
      @filter_logs = @filter_logs.where("papers.public_date BETWEEN '#{init_public_date}' and '#{end_public_date}'")
    end
    if years.present?
      years_id = Student.where(:years => years).pluck(:id)
      @filter_logs = @filter_logs.where(:student_id => years_id)
    end
    session[:filter_papers_id] = @filter_logs.pluck(:id)

    respond_to do |format|
      format.html { redirect_to '/user_analytics?filter=true' }
      format.json { render :index, status: :ok, location: @filter_logs }
    end

  end

end
