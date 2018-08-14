class PaperSetPapersship < ApplicationRecord
    belongs_to :paper_set , required: false
    belongs_to :paper , required: false
end
