require 'rails_helper'

describe 'Question API' do
  describe 'GET/index' do
    it_behaves_like 'API Authenticable'

    context 'authorized' do
      let(:access_token) { create(:access_token) }
      let!(:old_question) { create(:question, created_at: 2.days.ago) }
      let!(:question) { create(:question) }
      let!(:answer) { create(:answer, question: question) }
      let(:add_path) { '0/answers/0/' }
      let(:add_path_question) { '0/' }

      before { get '/api/v1/questions', format: :json, access_token: access_token.token }

      it_behaves_like 'API Success'
      it_behaves_like 'API List'
      it_behaves_like 'API question include'
      it_behaves_like 'API question short title'

      context 'answers' do
        it 'included in question object' do
          expect(response.body).to have_json_size(1).at_path("0/answers")
        end

        it_behaves_like 'API answer include'
      end
    end

    def do_request(options={})
      get '/api/v1/questions', { format: :json }.merge(options)
    end
  end

  describe 'GET/show' do
    let(:question) { create(:question) }
    it_behaves_like 'API Authenticable'

    context 'authorized' do
      let(:access_token) { create(:access_token) }
      let(:question) { create(:question) }
      let!(:attachment) { create(:attachment, attachmentable_id: question.id, attachmentable_type: 'Question') }
      let!(:comment) { create(:comment, commentable_id: question.id, commentable_type: 'Question') }
      let(:add_path_question) { '' }

      before { get "/api/v1/questions/#{question.id}", format: :json, access_token: access_token.token }

      it_behaves_like 'API Success'
      it_behaves_like 'API question include'
      it_behaves_like 'API question short title'
      it_behaves_like 'API attachment'
      it_behaves_like 'API comments'
    end

    def do_request(options={})
      get "/api/v1/questions/#{question.id}", { format: :json }.merge(options)
    end
  end

  describe 'POST/create' do
    let(:user) { create(:user) }
    let(:access_token) { create(:access_token, resource_owner_id: user.id) }
    let(:association) { user.questions }
    let(:valid) { '' }
    let(:instance) { :question }
    let(:type_instance) { :invalid_question}

    it_behaves_like 'API create new object'
  end
end
