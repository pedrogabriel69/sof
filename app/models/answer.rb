class Answer < ApplicationRecord
  include Votable
  include Commentable

  after_commit :send_email, on: :create

  belongs_to :question, touch: true

  validates :body, presence: true

  scope :ordered, -> { order('flag DESC, created_at') }

  def choose_answer(question)
    Answer.transaction do
      question.answers.update_all(flag: false)
      update!(flag: true)
    end
  end

  def send_email
    NewAnswerJob.perform_later(self) if question.check_follow
    NewAnswerFollowJob.perform_later(self)
  end
end
