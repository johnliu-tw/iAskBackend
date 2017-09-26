class PaperSubject < ApplicationRecord
    has_many :subjects, :through => :papersubject_subjectships
    has_many :papersubject_subjectships
    accepts_nested_attributes_for :papersubject_subjectships
end
