class Paper < ApplicationRecord

    has_many :selection_questions
    has_many :writing_questions
    has_many :paper_gradeships
    has_many :grades, :through => :paper_gradeships
    belongs_to :paper_subject
    accepts_nested_attributes_for :paper_gradeships
    
end
