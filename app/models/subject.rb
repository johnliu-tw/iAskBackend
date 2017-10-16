class Subject < ApplicationRecord
    has_many :paper_subjects
    has_many :paper_subjects, :through => :papersubject_subjectships
    has_many :papersubject_subjectships
    accepts_nested_attributes_for :papersubject_subjectships
end
