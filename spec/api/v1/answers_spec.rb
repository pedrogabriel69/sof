require 'rails_helper'

describe 'Answer API' do
  describe 'GET/index' do
    context 'authorized' do
      let(:access_token) { create(:access_token) }
      let!(:question) { create(:question) }
      let!(:answers) { create_list(:answer, 2, question: question) }
      let!(:answer) { answers.first }

      before { get "/api/v1/questions/#{question.id}/answers", format: :json, access_token: access_token.token }

      it "returns status 200" do
        expect(response).to be_success
      end
    end
  end
end
