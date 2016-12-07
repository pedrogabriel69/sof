class Comment < ApplicationRecord
  belongs_to :commentable, required: false, polymorphic: true
  belongs_to :user

  scope :ordered_comment, -> { order('created_at ASC') }
end
