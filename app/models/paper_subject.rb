class PaperSubject < ApplicationRecord
    has_many :subjects
    has_many :subjects, :through => :subjects

    accepts_nested_attributes_for :subjects
end
