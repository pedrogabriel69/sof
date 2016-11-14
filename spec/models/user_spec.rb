require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of :name }
  it { should validate_presence_of :email }
  it { should validate_presence_of :password }
  it { should have_many(:questions).dependent(:destroy) }
  it { should have_many(:answers).dependent(:destroy) }

  describe '#author?' do
    let(:user) { create(:user) }
    let(:new_user) { create(:user) }
    let(:question) { create(:question, user: user) }

    it 'User is author this question' do
      expect(user.author?(question)).to eq true
    end

    it 'User is not author this question' do
      expect(new_user.author?(question)).to eq false
    end
  end
end
