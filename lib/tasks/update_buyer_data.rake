namespace :create do
    task :update_buyer_data => [ :environment ] do
        @buy_logs = StudentBuyLog.all
        @buy_logs.each{
          |buy_log|
          puts buy_log.id
          if buy_log.student_id != nil
            if !Student.where(:id => buy_log.student_id).present?
              case PaperSet.find(buy_log.paper_set_id).platform_type
              when 0 #iAsk
                url = "http://66.172.12.87:3001/listStudentsByUids/"+buy_log.student_id
                response = RestClient.get(url, headers={'Content-Type' => 'application/json', 'apiKey' => 'testApiKey'})
                response = JSON.parse(response.to_s.tr('$', ''))[0]
    
                if response["name"] && !response["tutorType"].present?
                  grade = "國小"
                  if Grade.find(response["grade"]).name.include?("國")
                    grade = "國中"
                  elsif Grade.find(response["grade"]).name.include?("高")
                    grade = "高中"
                  end
                  
                  if response["school"].present?
                    Student.create(:id => response["id"],:name => response["name"],
                                  :years => Grade.find(response["grade"]).name, :grade => grade,
                                  :school => response["school"][response["school"].size-1],
                                  :register_time => Time.at(response["createdAt"]/1000), :account => response["email"])  
                  else
                    Student.create(:id => response["id"],:name => response["name"],
                                  :years => Grade.find(response["grade"]).name, :grade => grade,
                                  :register_time => Time.at(response["createdAt"]/1000), :account => response["email"])  
                  end
                elsif response["name"].present?
                  Student.create(:id => response["id"],:name => response["name"],
                  :register_time => Time.at(response["createdAt"]/1000), :account => response["email"])  
              end  
    
              when 2 #reader
                url = "http://66.172.11.58:3001/listStudentsByUids/"+buy_log.student_id
                response = RestClient.get(url, headers={'Content-Type' => 'application/json', 'apiKey' => 'testApiKey'})
                response = JSON.parse(response.to_s.tr('$', ''))[0]  
                if response["name"] && !response["tutorType"].present?
                  Student.create(:id => response["id"],:name => response["name"],
                  :register_time => Time.at(response["createdAt"]/1000), :account => response["email"])
                elsif response["tutorType"].present?
                  Student.find(response["id"]).update(:id => response["id"],:name => response["name"],:register_time => Time.at(response["createdAt"]/1000), :account => response["email"])  
                end  
              when 1 #udn
                url = "http://69.90.132.97:3001/listStudentsByUids/"+buy_log.student_id
                response = RestClient.get(url, headers={'Content-Type' => 'application/json', 'apiKey' => 'testApiKey'})
                response = JSON.parse(response.to_s.tr('$', ''))[0]  
                if response["name"].present? && !response["tutorType"].present?
                  grade = "國小"
                  if Grade.find(response["grade"]).name.include?("國")
                    grade = "國中"
                  elsif Grade.find(response["grade"]).name.include?("高")
                    grade = "高中"
                  end
                  if response["schoolName"].present?
                    Student.create(:id => response["id"],:name => response["name"],
                                :years => Grade.find(response["grade"]).name, :grade => grade,
                                :school => response["schoolName"][response["schoolName"].size-1],
                                :register_time => Time.at(response["createdAt"]/1000), :account => response["email"]) 
                  else
                    Student.create(:id => response["id"],:name => response["name"],
                                :years => Grade.find(response["grade"]).name, :grade => grade,
                                :register_time => Time.at(response["createdAt"]/1000), :account => response["email"])                 
                  end 
                elsif response["name"].present?
                  Student.create(:id => response["id"],:name => response["name"], :register_time => Time.at(response["createdAt"]/1000), :account => response["email"])  
                end  
              else
                Rails.logger.debug("Platform ID out of range")
              end
            else 
              case PaperSet.find(buy_log.paper_set_id).platform_type
                when 0
                  url = "http://66.172.12.87:3001/listStudentsByUids/"+buy_log.student_id
                  response = RestClient.get(url, headers={'Content-Type' => 'application/json', 'apiKey' => 'testApiKey'})
                  response = JSON.parse(response.to_s.tr('$', ''))[0]
      
                  if response["name"] && !response["tutorType"].present?
                    grade = "國小"
                    if Grade.find(response["grade"]).name.include?("國")
                      grade = "國中"
                    elsif Grade.find(response["grade"]).name.include?("高")
                      grade = "高中"
                    end
      
                    if response["school"].present?
                      Student.find(response["id"]).update(:id => response["id"],:name => response["name"],
                                  :years => Grade.find(response["grade"]).name, :grade => grade,
                                  :school => response["school"][response["school"].size-1],
                                  :register_time => Time.at(response["createdAt"]/1000), :account => response["email"])  
                    else 
                      Student.find(response["id"]).update(:id => response["id"],:name => response["name"],
                      :years => Grade.find(response["grade"]).name, :grade => grade,
                      :register_time => Time.at(response["createdAt"]/1000), :account => response["email"])                                     
                    end
                  elsif response["name"].present?
                    Student.find(response["id"]).update(:id => response["id"],:name => response["name"],
                    :grade => grade, :register_time => Time.at(response["createdAt"]/1000), :account => response["email"])  
                  end  
      
                when 2
                  url = "http://66.172.11.58:3001/listStudentsByUids/"+buy_log.student_id
                  response = RestClient.get(url, headers={'Content-Type' => 'application/json', 'apiKey' => 'testApiKey'})
                  response = JSON.parse(response.to_s.tr('$', ''))[0]  
                  if response["name"]
                    Student.find(response["id"]).update(:id => response["id"],:name => response["name"],
                    :register_time => Time.at(response["createdAt"]/1000), :account => response["email"])
                  elsif response["tutorType"].present?
                    Student.find(response["id"]).update(:id => response["id"],:name => response["name"],:register_time => Time.at(response["createdAt"]/1000), :account => response["email"])  
                  end  
                when 1
                  url = "http://69.90.132.97:3001/listStudentsByUids/"+buy_log.student_id
                  response = RestClient.get(url, headers={'Content-Type' => 'application/json', 'apiKey' => 'testApiKey'})
                  response = JSON.parse(response.to_s.tr('$', ''))[0]  
                  if response["name"].present? && !response["tutorType"].present?
                    grade = "國小"
                    if Grade.find(response["grade"]).name.include?("國")
                      grade = "國中"
                    elsif Grade.find(response["grade"]).name.include?("高")
                      grade = "高中"
                    end
                    if response["schoolName"].present?
                      Student.find(response["id"]).update(:id => response["id"],:name => response["name"],
                                  :years => Grade.find(response["grade"]).name, :grade => grade,
                                  :school => response["schoolName"][response["schoolName"].size-1],
                                  :register_time => Time.at(response["createdAt"]/1000), :account => response["email"])  
                    else 
                      Student.find(response["id"]).update(:id => response["id"],:name => response["name"],
                      :years => Grade.find(response["grade"]).name, :grade => grade,
                      :register_time => Time.at(response["createdAt"]/1000), :account => response["email"])                                     
                    end
                  elsif response["name"].present?
                    Student.find(response["id"]).update(:id => response["id"],:name => response["name"],:register_time => Time.at(response["createdAt"]/1000), :account => response["email"])              
                  end
              end            
            end
          end
        }

    end
end