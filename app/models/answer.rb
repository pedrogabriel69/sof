class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user
  has_many :attachments, as: :attachmentable

  validates :body, presence: true

  accepts_nested_attributes_for :attachments

  scope :ordered, -> { order('flag DESC, created_at') }

  def choose_answer(question)
    Answer.transaction do
      question.answers.update_all(flag: false)
      update!(flag: true)
    end
  end
end
