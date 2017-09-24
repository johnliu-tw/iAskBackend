class QuestionPapership < ApplicationRecord
    belongs_to :papers
    belongs_to :selection_questions
    belongs_to :writing_questions   
end
