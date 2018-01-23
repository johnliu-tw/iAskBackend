class StudentAnswerLog < ApplicationRecord
    belongs_to :students
    belongs_to :questions
end
