require 'rails_helper'

RSpec.describe DailyDigestJob, type: :job do
  let(:users) { create_list(:user, 2) }
  let(:questions){ create_list(:question, 3, created_at: Time.now) }

  it 'should send daily digest to all users' do
    users.each { |user| expect(DailyMailer).to receive(:digest).with(user, questions).and_call_original }
    DailyDigestJob.perform_now
  end
end
