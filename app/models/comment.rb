class Comment < ApplicationRecord
  belongs_to :commentable, required: false, polymorphic: true, touch: true
  belongs_to :user

  validates :body, presence: true

  scope :ordered_comment, -> { order('created_at ASC') }

  def return_id
    commentable_type == 'Question' ? commentable_id : Answer.find(commentable_id).question_id
  end
end
