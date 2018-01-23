class StudentPaperLog < ApplicationRecord
    belongs_to :papers, class_name: "Paper", foreign_key: "paper_id"
    belongs_to :students, class_name: "Student", foreign_key: "student_id"
end
