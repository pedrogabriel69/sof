class AttachmentSerializer < ActiveModel::Serializer
  attributes :id, :url, :attachmentable_id, :attachmentable_type

  def url
    object.file.url
  end
end
