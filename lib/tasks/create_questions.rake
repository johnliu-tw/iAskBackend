
require 'csv'
namespace :csv do 
    task :load_data => [ :environment ] do
    csv_text = File.expand_path('../rowdata.csv', __FILE__)
    counter = 0
        CSV.foreach(csv_text) do |row|
            counter = counter + 1
                Question.create do |q|
                    q.questionE = row[1]
                    q.analysis_url = row[2]
                    q.position = row[5]
                    q.title = row[6]
                    q.title_attr = row[7]
                    q.questionA = row[8]
                    q.questionB = row[9]
                    q.questionC = row[10]
                    q.questionD = row[11]
                    q.questionA_attr = row[12]    
                    q.questionB_attr = row[13]    
                    q.questionC_attr = row[14]    
                    q.questionD_attr = row[15]
                    q.answer = row[16]
                    q.analysis = row[17]
                    q.analysis_att = row[18]
                    q.active = row[19]             
                    q.optionCount = 5
                    q.paper_id = 1
                    q.platform_type = 0
                    q.question_type = "單選"
                end
            puts counter
        end
    end
end