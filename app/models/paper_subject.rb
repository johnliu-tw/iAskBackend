class PaperSubject < ApplicationRecord
    has_many :subjects, :through => :papersubject_subjectships
    has_many :papersubject_subjectships
    has_many :paper
    accepts_nested_attributes_for :papersubject_subjectships
end
