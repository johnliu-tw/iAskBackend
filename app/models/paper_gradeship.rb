class PaperGradeship < ApplicationRecord
    belongs_to :paper , required: false
    belongs_to :grade , required: false
end
