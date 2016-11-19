class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user

  validates :body, presence: true

  def choose_answer(question)
    # answers = question.answers
    old_answer = question.answers.where(flag: true).first
    old_answer.update_attributes(flag: false) if old_answer

    update_attributes(flag: true)
    # question.answers.insert(0, question.answers.to_a.delete_at(@answer))
  end
end
