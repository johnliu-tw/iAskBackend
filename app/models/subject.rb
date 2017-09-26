class Subject < ApplicationRecord
    has_many :paper_subjects
    has_many :paper_subjects, :through => :papersubject_subjectships
end
