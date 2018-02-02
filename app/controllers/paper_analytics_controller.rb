class PaperAnalyticsController < ApplicationController
  protect_from_forgery except: :filter
  
  def index
    @papers = Paper.all.paginate(:page => params[:page], :per_page => 10)

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
      platform_type = 0
      # detect order by which parameter
      if orderParam == nil
        orderParam = "id"
      end
      # detect order
      if order == nil
        order = "DESC"
      end

      if params[:relation] == "paper_subjects"
          @papers = Paper.includes(:paper_subject).where(platform_type: platform_type).order("paper_subjects.title  #{order}").paginate(:page => params[:page], :per_page => 10)
      elsif params[:relation] == "grades"
          @papers = Paper.includes(:grades).where(platform_type: platform_type).order("grades.name  #{order}").paginate(:page => params[:page], :per_page => 10)
      elsif params[:relation] == "questions"
          @papers = Paper.left_joins(:questions).group(:id).where(platform_type: platform_type).order("COUNT(questions.id) #{order}").paginate(:page => params[:page], :per_page => 10)
      elsif params[:relation] == "student_open_paper_logs" 
          @papers = Paper.left_joins(:student_open_paper_logs).where(platform_type: platform_type).group(:id).order("COUNT(student_open_paper_logs.id) #{order}").paginate(:page => params[:page], :per_page => 10)
      else
          @papers = Paper.order("#{orderParam}  #{order}").where(platform_type: platform_type).paginate(:page => params[:page], :per_page => 10)
      end
    else
        @papers = Paper.where(:id => session[:filter_papers_id],platform_type: platform_type).paginate(:page => params[:page], :per_page => 10)
    end

      @papers = assign_fake_attribute(@papers)
  end


  def assign_fake_attribute(papers)
    papers.each{
      |paper| 
      correct_rate = 0
      total_size = StudentCorrectRate.where(:paper_id => paper.id).size

      # count correct rate
      correct_size = StudentCorrectRate.where(:paper_id => paper.id, :correct_rate => "100.0").size
      if total_size == 0
        correct_rate = 0
      else
        correct_rate = (correct_size.to_f / total_size.to_f)*100
      end

      # count finished rate
      answered_size = StudentCorrectRate.where(:paper_id => paper.id, :finished => true).size

      if total_size == 0
        finish_rate = 0
      else
        finish_rate = (answered_size.to_f / total_size.to_f)*100
      end

      #count answer time
      answer_time = 0
      answer_logs = StudentAnswerLog.where(:question_id => paper.questions.pluck(:id)).order(:created_at, :student_id)

      if answer_logs.present?
        pre_time = answer_logs.first.created_at
      end
      current_time = nil
      answer_logs.each{
        |answer_log|
        current_time = answer_log.created_at
        time_log = current_time - pre_time

        if time_log < 3600000 
          answer_time = answer_time + time_log
        end

        pre_time = answer_log.created_at
      }
      answer_time = Time.at(answer_time/1000).strftime("%H:%M:%S")

      paper.update!(:correct_rate => correct_rate.round(2), :finish_rate => finish_rate.round(2),
                    :answer_time =>  answer_time)  
    }
    return papers
  end

  
  def filter
    subject_name = params[:filter][:subject_name]
    grade_name = params[:filter][:grade_name]
    init_public_date = params[:filter][:init_public_date]
    end_public_date = params[:filter][:end_public_date]    
    active = params[:filter][:active]       
    visible = params[:filter][:visible]    


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
    if visible.present?
      @filter_papers = @filter_papers.where(:visible => visible)
    end
    session[:filter_papers_id] = @filter_papers.pluck(:id)

    respond_to do |format|
      format.html { redirect_to '/paper_analytics?filter=true' }
      format.json { render :index, status: :ok, location: @filter_papers }
    end

  end

end
