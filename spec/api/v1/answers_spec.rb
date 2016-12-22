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

        %w(id created_at updated_at attachmentable_id attachmentable_type).each do |elem|
          it "attachment object contains #{elem}" do
            expect(response.body).to be_json_eql(attachment.send(elem.to_sym).to_json).at_path("attachments/0/#{elem}")
          end
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
end
