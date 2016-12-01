require 'rails_helper'

RSpec.shared_examples "voted" do
  let(:user) { create(:user) }

  describe 'GET #like' do
    it 'like' do
      expect { get :like, params: params_votable, format: :json }.to change(votable.votes, :count).by(1)
    end
  end

  describe 'GET #unlike' do
    it 'unlike' do
      expect { get :unlike, params: params_votable, format: :json }.to change(votable.votes, :count).by(1)
    end
  end
end
