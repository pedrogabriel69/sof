class Attachment < ApplicationRecord
  belongs_to :attachmentable, required: false, polymorphic: true

  mount_uploader :file, FileUploader
end
