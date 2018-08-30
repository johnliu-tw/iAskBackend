require 'rake'
    namespace :migrate do 
        task :paper_set_paper_relation => [ :environment ] do
            @papers = Paper.where.not(paper_set_id: nil)
            @papers.each do |paper|
                data = PaperSetPapersship.new(paper_id: paper.id, paper_set_id:paper.paper_set_id)
                data.save!
            end
        end
        task :migrate_question_type => [ :environment ] do
            Question.where(question_type:"單選").update(question_type: "single")
            Question.where(question_type:"複選").update(question_type: "multiple")
            Question.where(question_type:"非選").update(question_type: "nonchoice")
            Question.where(question_type:"題幹").update(question_type: "vignette")
            Question.where(question_type:"題幹(只有敘 述)").update(question_type: "vignette")
            Question.where(title_url_show_type:"原始影片").update(title_url_show_type: "raw")
            Question.where(title_url_show_type:"連結按鈕").update(title_url_show_type: "raw")
            Question.where(analysis_url_show_type:"原始影片").update(analysis_url_show_type: "raw")
            Question.where(analysis_url_show_type:"連結按鈕").update(analysis_url_show_type: "raw")
            Question.where(title_url_show_type:"顯示預覽").update(title_url_show_type: "preview")
            Question.where(analysis_url_show_type:"顯示預覽").update(title_url_show_type: "preview")
        end
end