class Question < ApplicationRecord
  include Votable
  include Commentable

  has_many :answers, dependent: :destroy
  has_many :follows, as: :followable, dependent: :destroy

  validates :title, :body, presence: true

  scope :ordered_question, -> { order(created_at: :desc) }
  scope :last_questions, -> { where(created_at: (Time.now - 24.hours)..Time.now) }

  def change_subscr
    update(check_follow: !check_follow)
  end
end
