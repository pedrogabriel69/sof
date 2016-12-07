class Comment < ApplicationRecord
  belongs_to :commentable, required: false, polymorphic: true
  belongs_to :user
end
