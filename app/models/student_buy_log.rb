class StudentBuyLog < ApplicationRecord
    belongs_to :student
    belongs_to :paper_set
    has_many :papers, :through => :paper_set
end
