class Grade < ApplicationRecord
    has_many :papers
    has_many :paper_gradeships 
    has_many :papers, :through => :paper_gradeships
    accepts_nested_attributes_for :paper_gradeships
end
