class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user

  validates :body, presence: true

  scope :ordered, -> { order(flag: :desc) }

  def choose_answer(question)
    # can you check it please?
    Answer.transaction do
      question.answers.update_all(flag: false)
      update!(flag: true)
    end
  end
end
