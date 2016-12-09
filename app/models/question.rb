class Question < ApplicationRecord
  include Votable
  include Commentable

  has_many :answers, dependent: :destroy

  validates :title, :body, presence: true
end
