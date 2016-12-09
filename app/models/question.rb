class Question < ApplicationRecord
  include Votable
  include Commentable

  has_many :answers, dependent: :destroy

  validates :title, :body, presence: true

  scope :ordered_question, -> { order('created_at ASC') }
end
