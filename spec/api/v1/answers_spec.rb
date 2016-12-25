require 'rails_helper'

describe 'Answer API' do
  describe 'GET/index' do
    let(:question) { create(:question) }
    it_behaves_like 'API Authenticable'

    context 'authorized' do
      let(:access_token) { create(:access_token) }
      let!(:question) { create(:question) }
      let!(:answers) { create_list(:answer, 2, question: question) }
      let!(:answer) { answers.first }
      let(:add_path) { '0/' }

      before { get "/api/v1/questions/#{question.id}/answers", format: :json, access_token: access_token.token }

      it_behaves_like 'API Success'
      it_behaves_like 'API List'
      it_behaves_like 'API answer include'
    end

    def do_request(options={})
      get "/api/v1/questions/#{question.id}/answers", { format: :json }.merge(options)
    end
  end

  describe 'GET/show' do
    let(:question) { create(:question) }
    let(:answer) { create(:answer, question: question) }
    it_behaves_like 'API Authenticable'

    context 'authorized' do
      let(:access_token) { create(:access_token) }
      let(:question) { create(:question) }
      let(:answer) { create(:answer, question: question) }
      let!(:attachment) { create(:attachment, attachmentable_id: answer.id, attachmentable_type: 'Answer') }
      let!(:comment) { create(:comment, commentable_id: answer.id, commentable_type: 'Answer') }
      let(:add_path) { '' }

      before { get "/api/v1/questions/#{question.id}/answers/#{answer.id}", format: :json, access_token: access_token.token }

      it_behaves_like 'API Success'
      it_behaves_like 'API answer include'
      it_behaves_like 'API attachment'
      it_behaves_like 'API comments'
    end

    def do_request(options={})
      get "/api/v1/questions/#{question.id}/answers/#{answer.id}", { format: :json }.merge(options)
    end
  end

  describe 'POST/create' do
    let(:user) { create(:user) }
    let(:access_token) { create(:access_token, resource_owner_id: user.id) }
    let(:question) { create(:question, user: user) }
    let(:association) { question.answers }
    let(:valid) { "#{question.id}/answers" }
    let(:instance) { :answer }
    let(:type_instance) { :invalid_answer }

    it_behaves_like 'API create new object'
  end
end
