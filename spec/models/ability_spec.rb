require 'rails_helper'

RSpec.describe Ability, type: :model do
  subject(:ability) { Ability.new(user) }

  describe 'for guest' do
    let(:user) { nil }

    it { should be_able_to :read, Question }
    it { should be_able_to :read, Answer }
    it { should be_able_to :read, Comment }
    it { should_not be_able_to :manage, :all }
  end

  describe 'for admin' do
    let(:user) { create(:user, admin: true) }

    it { should be_able_to :manage, :all }
  end

  describe 'for user, not admin' do
    let(:user) { create(:user) }
    let(:other_user) { create(:user) }
    let(:question) { create(:question, user: user) }
    let(:other_question) { create(:question, user: other_user) }
    let(:answer) { create(:answer, user: user, question: question) }
    let(:other_answer) { create(:answer, user: other_user, question: question) }
    let(:answer_2) { create(:answer, user: other_user, question: other_question) }
    let(:attachment_question) { create(:attachment, attachmentable_id: question.id, attachmentable_type: 'Question') }
    let(:other_attachment_question) { create(:attachment, attachmentable_id: other_question.id, attachmentable_type: 'Question') }
    let(:attachment_answer) { create(:attachment, attachmentable_id: answer.id, attachmentable_type: 'Answer') }
    let(:other_attachment_answer) { create(:attachment, attachmentable_id: other_answer.id, attachmentable_type: 'Answer') }

    it { should_not be_able_to :manage, :all }
    it { should be_able_to :read, :all }

    it { should be_able_to :create, Question }
    it { should be_able_to :create, Answer }
    it { should be_able_to :create, Comment }
    it { should be_able_to :create, Attachment }

    it { should be_able_to :update, question, user: user }
    it { should_not be_able_to :update, other_question, user: user }

    it { should be_able_to :update, answer, user: user }
    it { should_not be_able_to :update, other_answer, user: user }

    it { should be_able_to :destroy, question, user: user }
    it { should_not be_able_to :destroy, other_question, user: user }

    it { should be_able_to :destroy, answer, user: user }
    it { should_not be_able_to :destroy, other_answer, user: user }

    it { should be_able_to :destroy, attachment_question, user: user }
    it { should_not be_able_to :destroy, other_attachment_question, user: user }

    it { should be_able_to :destroy, attachment_answer, user: user }
    it { should_not be_able_to :destroy, other_attachment_answer, user: user }

    it { should be_able_to :like, other_question, user: user }
    it { should_not be_able_to :like, question, user: user }

    it { should be_able_to :unlike, other_question, user: user }
    it { should_not be_able_to :unlike, question, user: user }

    it { should be_able_to :like, other_answer, user: user }
    it { should_not be_able_to :like, answer, user: user }

    it { should be_able_to :unlike, other_answer, user: user }
    it { should_not be_able_to :unlike, answer, user: user }

    it { should be_able_to :best, other_answer, user: user }
    it { should_not be_able_to :best, answer_2, user: user }
  end
end
