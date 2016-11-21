class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user

  validates :body, presence: true

  # scope :ordered, -> { order(flag: :desc).order(:created_at) }
  scope :ordered, -> { order('flag DESC, created_at') }

  def choose_answer(question)
    # can you check it please?
    Answer.transaction do
      question.answers.update_all(flag: false)
      update!(flag: true)
    end
  end
end
