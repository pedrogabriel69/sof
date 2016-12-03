require 'rails_helper'

RSpec.shared_examples "votable" do
  it { should belong_to :user }
  it { should have_many(:attachments).dependent(:destroy) }
  it { should have_many(:votes).dependent(:destroy) }
  it { should accept_nested_attributes_for :attachments }

  context '#liked_by' do
    let(:user) { create(:user) }

    it 'update' do
      vote = votable.votes.create(user: user, weight: -1)
      votable.liked_by(user)
      vote.reload
      expect(vote.weight).to eq 1
    end

    it 'create' do
      votable.liked_by(user)
      vote = votable.votes.find_by(user_id: user.id)
      expect(vote.weight).to eq 1
    end
  end

  context '#downvote_from' do
    let(:user) { create(:user) }

    it 'update' do
      vote = votable.votes.create(user: user, weight: 1)
      votable.downvote_from(user)
      vote.reload
      expect(vote.weight).to eq -1
    end

    it 'create' do
      votable.downvote_from(user)
      vote = votable.votes.find_by(user_id: user.id)
      expect(vote.weight).to eq -1
    end
  end
end
