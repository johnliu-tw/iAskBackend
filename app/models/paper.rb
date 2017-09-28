class Paper < ApplicationRecord

    has_many :selection_questions
    has_many :writing_questions
    has_many :paper_gradeships
    has_many :grades, :through => :paper_gradeships
    belongs_to :paper_subject, class_name: "PaperSubject", foreign_key: "paper_subject_id"
    accepts_nested_attributes_for :paper_gradeships
    
end
