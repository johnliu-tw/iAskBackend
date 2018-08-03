class Paper < ApplicationRecord

    attr_accessor :subject_name
    has_many :questions, :dependent => :destroy
    has_many :student_paper_logs, :dependent => :destroy
    has_many :student_open_paper_logs, :dependent => :destroy
    has_many :paper_gradeships, :dependent => :destroy
    belongs_to :paper_set
    has_many :grades, :through => :paper_gradeships
    has_many :students, :through => :student_paper_logs
    belongs_to :paper_subject, class_name: "PaperSubject", foreign_key: "paper_subject_id"
    accepts_nested_attributes_for :paper_gradeships
    accepts_nested_attributes_for :student_paper_logs

    
end
