class UserAnalyticsController < ApplicationController

  def index

    @student_answer_logs = StudentAnswerLog.distinct(:student_id).all
    update_student_data(@student_answer_logs)

    @student_paper_logs = StudentPaperLog.all
    @papers = Paper.all.paginate(:page => params[:page], :per_page => 10)


  end





  def update_student_data(student_answer_logs)

    student_answer_logs.each{
      |student_answer_log|
      if student_answer_log.student_id != nil
        if !Student.where(:id => student_answer_log.student_id).present?
          case Paper.find(Question.find(student_answer_log.question_id).paper_id).platform_type
          when 0
            url = "http://66.172.12.87:3001//listStudentsByUids/"+student_answer_log.student_id
            response = RestClient.get(url, headers={'Content-Type' => 'application/json', 'apiKey' => 'testApiKey'})
            grade = "國小"
            if Grade.find(response[0].grade).name.include("國")
              grade = "國中"
            elsif Grade.find(response[0].grade).name.include("高")
              grade = "高中"
            end
            Student.create(:id => response[0].$id, :name => response[0].name,
                           :years => Grade.find(response[0].grade.name, :grade => grade,
                           :school => rasponse[0].schoolName[rasponse[0].schoolName-1])

          when 1
            url = "http://52.69.167.52:3001/listStudentsByUids/"+student_answer_log.student_id
            response = RestClient.get(url, headers={'Content-Type' => 'application/json', 'apiKey' => 'testApiKey'})
            Student.create(:id => response[0].$id, :name => response[0].name)
          when 2
            url = "http://66.172.11.58:3001/listStudentsByUids/"+student_answer_log.student_id
            response = RestClient.get(url, headers={'Content-Type' => 'application/json', 'apiKey' => 'testApiKey'})
            Student.create(:id => response[0].$id, :name => response[0].name)
          else
            Rails.logger.debug("Platform ID out of range")
          end
        end
      end
    }  
  end
end
