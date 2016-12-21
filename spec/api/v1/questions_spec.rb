require 'rails_helper'

describe 'Profile API' do
  describe 'GET/index' do
    context 'unauthorized' do
      it "returns 401 status if access token doesn't exist" do
        get '/api/v1/questions', format: :json
        expect(response.status).to eq 401
      end

      it "returns 401 status if access token is invalid" do
        get '/api/v1/questions', format: :json, access_token: '1234'
        expect(response.status).to eq 401
      end
    end

    context 'authorized' do
      let(:access_token) { create(:access_token) }
      let!(:questions) { create_list(:question, 2) }
      let(:question) { questions.first }
      let!(:answer) { create(:answer, question: question) }

      before { get '/api/v1/questions', format: :json, access_token: access_token.token }

      it "returns status 200" do
        expect(response).to be_success
      end

      it 'return list questions' do
        expect(response.body).to have_json_size(2)
      end

      %w(id title body created_at updated_at).each do |elem|
        it "question object contains #{elem}" do
          expect(response.body).to be_json_eql(question.send(elem.to_sym).to_json).at_path("0/#{elem}")
        end
      end

      it 'question object contains short title' do
        expect(response.body).to be_json_eql(question.title.truncate(10).to_json).at_path("0/short_title")
      end

      context 'answers' do
        it 'included in question object' do
          expect(response.body).to have_json_size(1).at_path("0/answers")
        end

        %w(id body created_at updated_at).each do |elem|
          it "answer object contains #{elem}" do
            expect(response.body).to be_json_eql(answer.send(elem.to_sym).to_json).at_path("0/answers/0/#{elem}")
          end
        end
      end
    end
  end
end
