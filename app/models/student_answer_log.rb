class StudentAnswerLog < ApplicationRecord
    belongs_to :student
    belongs_to :question
    belongs_to :student_open_question_log
end
