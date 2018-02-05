class PaperSet < ApplicationRecord
    has_many :papers
    has_many :student_buy_logs
    attr_accessor :paper_ids  
end
