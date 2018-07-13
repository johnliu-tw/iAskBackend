namespace :create do 
    task :student_paper_log => [ :environment ] do
        @student_answer_logs = StudentAnswerLog.all
        @student_answer_logs.each do |log|
            puts log.id
            #count answer time 
            answer_time = 0
            answer_logs = StudentAnswerLog.where(:question_id => log.question_id, :student_id => log.student_id).order(:created_at)
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
            
            answer_time = Time.at(answer_time).strftime("%H:%M:%S")

            #count finish rate
            total_size = log.question.paper.questions.size
            finish_size = StudentAnswerLog.distinct(:question_id).where(:question_id => log.question_id, :student_id => log.student_id).size
            finish_rate = (finish_size.to_f / total_size.to_f)*100

            #count correct rate
            if log.student.present?
              correct_rate = log.student.student_correct_rates.where(:paper_id => log.question.paper.id)[0].correct_rate
            else
              correct_rate = 100
            end
            #count answer times

            question_ids = Paper.find(log.question.paper_id).questions.pluck(:id)
            answer_times = StudentAnswerLog.where(:question_id => question_ids, :student_id => log.student_id).size

            @student_paper_log = StudentPaperLog.where(:student_id => log.student_id, :paper_id=> log.question.paper)
            if @student_paper_log.present?    
              @student_paper_log.update(:finish_rate => finish_rate, :answer_time => answer_time, :correct_rate => correct_rate, :answer_times => answer_times)
            else
              StudentPaperLog.create(:student_id => log.student_id, :paper_id=> log.question.paper.id, :finish_rate => finish_rate, :answer_time => answer_time, :correct_rate => correct_rate, :answer_times => answer_times)
            end
        end
    end
end
