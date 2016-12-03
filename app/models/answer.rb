class Answer < ApplicationRecord
  include Votable

  belongs_to :question

  validates :body, presence: true

  scope :ordered, -> { order('flag DESC, created_at') }

  def choose_answer(question)
    Answer.transaction do
      question.answers.update_all(flag: false)
      update!(flag: true)
    end
  end
end
