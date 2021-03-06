module Votable
  extend ActiveSupport::Concern

  included do
    has_many :attachments, as: :attachmentable, dependent: :destroy
    has_many :votes, as: :votable, dependent: :destroy
    belongs_to :user

    accepts_nested_attributes_for :attachments, reject_if: :all_blank, allow_destroy: true
  end

  def liked_by(user)
    vote = votes.find_by(user_id: user.id)
    if vote
      update_vote_for(vote, 1) if vote.weight == -1
    else
      votes.create(user: user, weight: 1)
    end
  end

  def downvote_from(user)
    vote = votes.find_by(user_id: user.id)
    if vote
      update_vote_against(vote, -1) if vote.weight == 1
    else
      votes.create(user: user, weight: -1)
    end
  end

  def rating
    votes.sum(:weight)
  end

  private

  def update_vote_for(vote, val)
    vote.update(weight: val)
  end

  def update_vote_against(vote, val)
    vote.update(weight: val)
  end
end
