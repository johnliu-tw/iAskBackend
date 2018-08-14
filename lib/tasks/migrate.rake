require 'rake'
    namespace :migrate do 
        task :paper_set_paper_relation => [ :environment ] do
            @papers = Paper.where.not(paper_set_id: nil)
            @papers.each do |paper|
                data = PaperSetPapersship.new(paper_id: paper.id, paper_set_id:paper.paper_set_id)
                data.save!
            end
        end
end