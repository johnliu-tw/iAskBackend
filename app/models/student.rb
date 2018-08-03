class Student < ApplicationRecord
    has_many :student_open_paper_logs, :dependent => :destroy
    has_many :student_paper_logs, :dependent => :destroy
    has_many :student_open_question_logs, :dependent => :destroy
    has_many :student_correct_rates, :dependent => :destroy
    has_many :student_buy_logs, :dependent => :destroy
    has_many :student_ask_teacher_logs, :dependent => :destroy
    has_many :student_answer_logs, :dependent => :destroy
    has_many :papers, :through => :student_paper_logs
    accepts_nested_attributes_for :student_paper_logs
end
