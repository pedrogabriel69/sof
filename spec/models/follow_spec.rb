require 'rails_helper'

RSpec.describe Follow, type: :model do
  it { should belong_to :followable }
  it { should belong_to :user }

  describe 'uniqueness validation' do
    subject { build(:follow) }
    it { should validate_uniqueness_of(:user_id).scoped_to(:followable_id) }
  end
end
