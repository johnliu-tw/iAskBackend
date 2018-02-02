class StudentPaperLog < ApplicationRecord
    belongs_to :paper
    belongs_to :student
end
