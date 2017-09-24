class SelectionQuestion < ApplicationRecord
    has_many :papers
    has_many :papers, :through => :question_papership
end
