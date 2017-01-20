class Question < ApplicationRecord
  include Votable
  include Commentable

  has_many :answers, dependent: :destroy
  has_many :follows, as: :followable, dependent: :destroy

  validates :title, :body, presence: true

  scope :ordered_question, -> { order('created_at ASC') }
  scope :last_questions, -> { where(created_at: DateTime.yesterday) }
end
