namespace :create do
  task :update_student_data => [ :environment ] do
    @student_answer_logs = StudentAnswerLog.all
    student_answer_logs.each{
      |student_answer_log|
      if student_answer_log.student_id != nil
        if !Student.where(:id => student_answer_log.student_id).present?
          case Paper.find(Question.find(student_answer_log.question_id).paper_id).platform_type
          when 0
            url = "http://66.172.12.87:3001/listStudentsByUids/"+student_answer_log.student_id
            response = RestClient.get(url, headers={'Content-Type' => 'application/json', 'apiKey' => 'testApiKey'})
            response = JSON.parse(response.to_s.tr('$', ''))[0]

            if response["name"]
              grade = "國小"
              if Grade.find(response["grade"]).name.include("國")
                grade = "國中"
              elsif Grade.find(response["grade"]).name.include("高")
                grade = "高中"
              end

              Student.create(:id => response["id"],:name => response["name"],
                            :years => Grade.find(response["grade"]).name, :grade => grade,
                            :school => response["school"][response["school"].size-1])  
            end  

          when 1
            url = "http://52.69.167.52:3001/listStudentsByUids/"+student_answer_log.student_id
            response = RestClient.get(url, headers={'Content-Type' => 'application/json', 'apiKey' => 'testApiKey'})
            response = JSON.parse(response.to_s.tr('$', ''))[0]  
            if response["name"]
              Student.create(:id => response["id"],:name => response["name"])
            end  
          when 2
            url = "http://66.172.11.58:3001/listStudentsByUids/"+student_answer_log.student_id
            response = RestClient.get(url, headers={'Content-Type' => 'application/json', 'apiKey' => 'testApiKey'})
            response = JSON.parse(response.to_s.tr('$', ''))[0]  
            if response["name"]
              Student.create(:id => response["id"],:name => response["name"])
            end  
          else
            Rails.logger.debug("Platform ID out of range")
          end
        end
      end
    }
  end
end
