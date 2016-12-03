require 'rails_helper'

RSpec.describe Question, type: :model do
  it_behaves_like "votable" do
    let(:votable) { create(:question, user: user) }
  end


  it { should validate_presence_of :title }
  it { should validate_presence_of :body }
  it { should have_many(:answers).dependent(:destroy) }
end
