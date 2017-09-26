class Paper < ApplicationRecord
    has_many :selection_questions
    has_many :writing_questions
end
