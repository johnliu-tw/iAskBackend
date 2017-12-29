class PaperSet < ApplicationRecord
    has_many :papers
    attr_accessor :paper_ids  
end
