class PapersubjectSubjectship < ApplicationRecord
    belongs_to :subjects
    belongs_to :paper_subjects
end
