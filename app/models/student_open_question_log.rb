class StudentOpenQuestionLog < ApplicationRecord
    belongs_to :students
    has_many :student_answer_logs
end
