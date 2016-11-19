class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user

  validates :body, presence: true

  def choose_answer(question)
    old_answer = question.answers.where(flag: true).first
    old_answer.update_attributes(flag: false) if old_answer

    update_attributes(flag: true)
  end
end
