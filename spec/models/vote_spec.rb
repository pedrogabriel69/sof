require 'rails_helper'

RSpec.describe Vote, type: :model do
  it { should belong_to(:user) }
  it { should belong_to :votable }
  it { should validate_presence_of :votable }
  it { should validate_presence_of :choice }
  it { should validate_presence_of :weight }
end
