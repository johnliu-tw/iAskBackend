class StudentBuyLog < ApplicationRecord
    belongs_to :student
    belongs_to :paper_set
end
