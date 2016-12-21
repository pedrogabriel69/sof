class AnswerSerializer < ActiveModel::Serializer
  attributes :id, :body, :created_at, :updated_at, :question_id
  belongs_to :question
  has_many :attachments
  has_many :comments
end
