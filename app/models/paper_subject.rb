class PaperSubject < ApplicationRecord
    has_many :subjects, :through => :papersubject_subjectships
    has_many :student_paper_logs, :through => :papers
    has_many :papersubject_subjectships
    has_many :papers
    accepts_nested_attributes_for :papersubject_subjectships
end
