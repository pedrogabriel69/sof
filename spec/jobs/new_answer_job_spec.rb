require 'rails_helper'

RSpec.describe NewAnswerJob, type: :job do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:question) { create(:question, user: user) }
  let(:answer) { create(:answer, user: other_user, question: question) }

  it 'should send mail to author question' do
    expect(DailyMailer).to receive(:new_answer).with(user, answer).and_call_original
    NewAnswerJob.perform_now(answer)
  end
end
