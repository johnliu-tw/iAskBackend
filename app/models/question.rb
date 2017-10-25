class Question < ApplicationRecord
    belongs_to :papers

    mount_uploader :title_attr, ImageUploader
    mount_uploader :questionA_attr, ImageUploader
    mount_uploader :questionB_attr, ImageUploader
    mount_uploader :questionC_attr, ImageUploader
    mount_uploader :questionD_attr, ImageUploader
    mount_uploader :questionE_attr, ImageUploader
    mount_uploader :questionF_attr, ImageUploader
    mount_uploader :questionG_attr, ImageUploader
    mount_uploader :questionH_attr, ImageUploader
    mount_uploader :analysis_att, ImageUploader

    validates_processing_of :title_attr
    validates_processing_of :questionA_attr
    validates_processing_of :questionB_attr
    validates_processing_of :questionC_attr
    validates_processing_of :questionD_attr
    validates_processing_of :questionE_attr
    validates_processing_of :questionF_attr
    validates_processing_of :questionG_attr
    validates_processing_of :questionH_attr
    validates_processing_of :analysis_att
    validate :image_size_validation
     
    private
      def image_size_validation
        errors[:image] << "Title should be less than 350KB" if title_attr.size > 0.35.megabytes
        errors[:image] << "QA should be less than 350KB" if questionA_attr.size > 0.35.megabytes
        errors[:image] << "QB should be less than 350KB" if questionB_attr.size > 0.35.megabytes
        errors[:image] << "QC should be less than 350KB" if questionC_attr.size > 0.35.megabytes
        errors[:image] << "QD should be less than 350KB" if questionD_attr.size > 0.35.megabytes
        errors[:image] << "QE should be less than 350KB" if questionE_attr.size > 0.35.megabytes
        errors[:image] << "QF should be less than 350KB" if questionF_attr.size > 0.35.megabytes
        errors[:image] << "QG should be less than 350KB" if questionG_attr.size > 0.35.megabytes
        errors[:image] << "QH should be less than 350KB" if questionH_attr.size > 0.35.megabytes
        errors[:image] << "Ans should be less than 350KB" if analysis_att.size > 0.35.megabytes
      end
end
