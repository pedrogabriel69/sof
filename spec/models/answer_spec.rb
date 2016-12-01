require 'rails_helper'

RSpec.describe Answer, type: :model do
  it_behaves_like "votable" do
    let(:question) { create(:question, user: user) }
    let(:votable) { create(:answer, question: question, user: user) }
  end


  it { should validate_presence_of :body }
  it { should belong_to :question }

  describe '#choose_answer' do
    let(:user) { create(:user) }
    let!(:question) { create(:question, user: user) }
    let!(:a1) { create(:answer, user: user, question: question) }
    let!(:a2) { create(:answer, user: user, question: question, flag: true) }

    it 'Flag shoud be change' do
      expect(a1.choose_answer(question)).to eq true
      a1.reload
      a2.reload
      expect(a2.flag).to eq false
      expect(a1.flag).to eq true
    end
  end
end
