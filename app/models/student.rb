class Student < ApplicationRecord
    has_many :student_open_paper_logs
    has_many :student_paper_logs
    has_many :student_open_question_logs
    has_many :student_correct_rates
    has_many :student_buy_logs
    has_many :student_ask_teacher_logs
    has_many :student_answer_logs
    has_many :papers, :through => :student_paper_logs
    accepts_nested_attributes_for :student_paper_logs
end
