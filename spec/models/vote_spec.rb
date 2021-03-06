require 'rails_helper'

RSpec.describe Vote, type: :model do
  it { should belong_to(:user) }
  it { should belong_to :votable }
  it {should validate_inclusion_of(:votable_type).in_array(%w[Question Answer]) }
  it {should validate_inclusion_of(:weight).in_array([-1, 1]) }

  describe 'uniqueness validation' do
    subject { build(:vote) }
    it { should validate_uniqueness_of(:user_id).scoped_to(:votable_type, :votable_id) }
  end
end
