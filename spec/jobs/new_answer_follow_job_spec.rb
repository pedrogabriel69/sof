require 'rails_helper'

RSpec.describe NewAnswerFollowJob, type: :job do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:question) { create(:question, user: user) }
  let(:answer) { create(:answer, user: other_user, question: question) }
  let(:follows) { create_list(:follow, 2, followable_type: 'Question', followable_id: question.id) }

  it 'should send mail to user that subscribe question' do
    follows.each { |follow| expect(DailyMailer).to receive(:new_answer_follow).with(follow.user, answer).and_call_original }
    NewAnswerFollowJob.perform_now(answer)
  end
end
