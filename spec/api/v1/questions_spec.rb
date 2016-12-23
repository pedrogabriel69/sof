require 'rails_helper'

describe 'Question API' do
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

  describe 'GET/show' do
    context 'unauthorized' do
      let(:question) {create(:question) }

      it "returns 401 status if access token doesn't exist" do
        get "/api/v1/questions/#{question.id}", format: :json
        expect(response.status).to eq 401
      end

      it "returns 401 status if access token is invalid" do
        get "/api/v1/questions/#{question.id}", format: :json, access_token: '1234'
        expect(response.status).to eq 401
      end
    end

    context 'authorized' do
      let(:access_token) { create(:access_token) }
      let(:question) { create(:question) }
      let!(:attachment) { create(:attachment, attachmentable_id: question.id, attachmentable_type: 'Question') }
      let!(:comment) { create(:comment, commentable_id: question.id, commentable_type: 'Question') }

      before { get "/api/v1/questions/#{question.id}", format: :json, access_token: access_token.token }

      it "returns status 200" do
        expect(response).to be_success
      end

      %w(id title body created_at updated_at).each do |elem|
        it "question object contains #{elem}" do
          expect(response.body).to be_json_eql(question.send(elem.to_sym).to_json).at_path("#{elem}")
        end
      end

      it 'question object contains short title' do
        expect(response.body).to be_json_eql(question.title.truncate(10).to_json).at_path("short_title")
      end

      context 'attachment' do
        it 'included in question object' do
          expect(response.body).to have_json_size(1).at_path("attachments")
        end

        %w(id attachmentable_id attachmentable_type).each do |elem|
          it "attachment object contains #{elem}" do
            expect(response.body).to be_json_eql(attachment.send(elem.to_sym).to_json).at_path("attachments/0/#{elem}")
          end
        end

        it 'attachment object contains url' do
          expect(response.body).to be_json_eql(attachment.file.url.to_json).at_path("attachments/0/url")
        end
      end

      context 'comment' do
        it 'included in question object' do
          expect(response.body).to have_json_size(1).at_path("comments")
        end

        %w(id body created_at updated_at commentable_id commentable_type).each do |elem|
          it "comment object contains #{elem}" do
            expect(response.body).to be_json_eql(comment.send(elem.to_sym).to_json).at_path("comments/0/#{elem}")
          end
        end
      end
    end
  end

  describe 'POST/create' do
    let(:user) { create(:user) }
    let(:access_token) { create(:access_token, resource_owner_id: user.id) }

    context 'valid params' do
      let(:subject) { post "/api/v1/questions", format: :json, access_token: access_token.token, question: attributes_for(:question) }

      it 'returns status 201' do
        subject
        expect(response.status).to eq 201
      end

      it 'creates new question' do
        expect { subject }.to change(user.questions, :count).by(1)
      end
    end

    context 'invalid params' do
      let(:subject) { post "/api/v1/questions", format: :json, access_token: access_token.token, question: attributes_for(:invalid_question) }

      it 'returns status 422' do
        subject
        expect(response.status).to eq 422
      end

      it "doest't creates new question" do
        expect { subject }.to_not change(user.questions, :count)
      end
    end
  end
end
