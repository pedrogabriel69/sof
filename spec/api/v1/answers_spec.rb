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

      it 'return list answers' do
        expect(response.body).to have_json_size(2)
      end

      %w(id body created_at updated_at question_id).each do |elem|
        it "answer object contains #{elem}" do
          expect(response.body).to be_json_eql(answer.send(elem.to_sym).to_json).at_path("0/#{elem}")
        end
      end
    end
  end

  describe 'GET/show' do
    context 'authorized' do
      let(:access_token) { create(:access_token) }
      let(:question) { create(:question) }
      let(:answer) { create(:answer, question: question) }
      let!(:attachment) { create(:attachment, attachmentable_id: answer.id, attachmentable_type: 'Answer') }
      let!(:comment) { create(:comment, commentable_id: answer.id, commentable_type: 'Answer') }

      before { get "/api/v1/questions/#{question.id}/answers/#{answer.id}", format: :json, access_token: access_token.token }

      it "returns status 200" do
        expect(response).to be_success
      end

      %w(id body created_at updated_at question_id).each do |elem|
        it "answer object contains #{elem}" do
          expect(response.body).to be_json_eql(answer.send(elem.to_sym).to_json).at_path("#{elem}")
        end
      end

      context 'attachment' do
        it 'included in answer object' do
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
        it 'included in answer object' do
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
    let(:question) { create(:question, user: user) }

    context 'valid params' do
      let(:subject) { post "/api/v1/questions/#{question.id}/answers", access_token: access_token.token, format: :json, answer: attributes_for(:answer) }

      it 'returns status 201' do
        subject
        expect(response.status).to eq 201
      end

      it "creates new answer" do
        expect { subject }.to change(question.answers, :count).by(1)
      end
    end

    context 'invalid params' do
      let(:subject) { post "/api/v1/questions/#{question.id}/answers", access_token: access_token.token, format: :json, answer: attributes_for(:invalid_answer) }

      it 'returns status 422' do
        subject
        expect(response.status).to eq 422
      end

      it "doest't creates new answer" do
        expect { subject }.to_not change(question.answers, :count)
      end
    end
  end
end
