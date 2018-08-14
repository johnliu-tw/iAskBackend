class Paper < ApplicationRecord

    attr_accessor :subject_name
    has_many :questions, :dependent => :destroy
    has_many :student_paper_logs, :dependent => :destroy
    has_many :student_open_paper_logs, :dependent => :destroy
    has_many :paper_gradeships, :dependent => :destroy
    has_many :paper_set_papersships, :dependent => :destroy
    belongs_to :paper_source
    has_many :grades, :through => :paper_gradeships
    has_many :students, :through => :student_paper_logs
    has_many :paper_sets, :through => :paper_set_papersships
    belongs_to :paper_subject, class_name: "PaperSubject", foreign_key: "paper_subject_id"
    accepts_nested_attributes_for :paper_gradeships
    accepts_nested_attributes_for :paper_set_papersships
    accepts_nested_attributes_for :student_paper_logs

    
end
