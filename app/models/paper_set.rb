class PaperSet < ApplicationRecord
    has_many :papers, :through => :paper_set_papersship
    has_many :student_buy_logs
    has_many :paper_set_papersship
    accepts_nested_attributes_for :paper_set_papersship
end
