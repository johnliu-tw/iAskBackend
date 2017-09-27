class Grade < ApplicationRecord
    has_many :papers
    has_many :papers, :through => :paper_gradeships
end
