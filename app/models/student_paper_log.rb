class StudentPaperLog < ApplicationRecord
    belongs_to :paper
    belongs_to :student
    has_many :paper_subjects, :through => :paper
    has_many :questions, :through => :paper
    
end
