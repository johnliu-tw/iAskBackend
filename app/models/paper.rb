class Paper < ApplicationRecord

    attr_accessor :subject_name
    attr_accessor :correct_rate    
    has_many :questions
    has_many :paper_gradeships
    has_many :grades, :through => :paper_gradeships
    belongs_to :paper_subject, class_name: "PaperSubject", foreign_key: "paper_subject_id"
    accepts_nested_attributes_for :paper_gradeships

    
end
