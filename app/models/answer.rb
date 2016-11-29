class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user
  has_many :votes, as: :votable, dependent: :destroy
  has_many :attachments, as: :attachmentable, dependent: :destroy

  validates :body, presence: true

  accepts_nested_attributes_for :attachments, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :votes

  scope :ordered, -> { order('flag DESC, created_at') }

  def choose_answer(question)
    Answer.transaction do
      question.answers.update_all(flag: false)
      update!(flag: true)
    end
  end

  def liked_by(user)
    vote = votes.where(user_id: user.id).first
    if vote
      update_vote_for(vote) if vote.choice == false
    else
      votes.create(user: user, choice: true)
    end
  end

  def downvote_from(user)
    vote = votes.where(user_id: user.id).first
    if vote
      update_vote_against(vote) if vote.choice == true
    else
      votes.create(user: user, choice: false)
    end
  end

  def votes_for_up
    votes.where(choice: true).size
  end

  def votes_for_down
    votes.where(choice: false).size
  end

  private

  def update_vote_for(vote)
    vote.update(choice: true)
  end

  def update_vote_against(vote)
    vote.update(choice: false)
  end
end
