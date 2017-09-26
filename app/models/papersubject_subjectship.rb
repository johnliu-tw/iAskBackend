class PapersubjectSubjectship < ApplicationRecord
    belongs_to :subject , required: false
    belongs_to :paper_subject , required: false
end
