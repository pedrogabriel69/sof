class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user

  validates :body, presence: true

  scope :ordered, -> { order(flag: :desc) }

  def choose_answer(question)
    question.answers.update_all(flag: false)
    update(flag: true)
  end
end
