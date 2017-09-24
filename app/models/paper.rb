class Paper < ApplicationRecord
    belongs_to :paper_subject
    has_many :selection_questions
    has_many :writing_questions
    has_many :selection_questions, :through => :question_papership
    has_many :writing_questions, :through => :question_papership
end
