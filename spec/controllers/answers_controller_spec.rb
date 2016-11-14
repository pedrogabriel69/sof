require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  sign_in_user
  let(:question) { create(:question, user: @user) }
  let(:answer) { create(:answer, user: @user, question: question) }

  let(:user) { create(:user, email: 'test@test.io') }
  let!(:other_answer) { create(:answer, user: user, question: question) }

  describe 'GET #edit' do
    before { get :edit, params: { question_id: question.id, id: answer.id } }

    it 'edit object' do
      expect(assigns(:answer)).to eq answer
    end

    it 'render edit view' do
      expect(response).to render_template(:edit)
    end
  end

  describe 'POST #create' do
    context 'correct work' do
      it 'create object' do
        expect { post :create, params: { user_id: @user, question_id: question, answer: attributes_for(:answer) } }.to change(question.answers, :count).by(1)
        expect { post :create, params: { user_id: @user, question_id: question, answer: attributes_for(:answer) } }.to change(@user.answers, :count).by(1)
      end

      it 'render show view' do
        post :create, params: { user_id: @user, question_id: question, answer: attributes_for(:answer) }
        expect(response).to redirect_to question
      end
    end

    context 'not correct work' do
      it 'create object' do
        expect { post :create, params: { question_id: question, user_id: @user, answer: attributes_for(:invalid_answer) } }.to_not change(question.answers, :count)
        expect { post :create, params: { question_id: question, user_id: @user, answer: attributes_for(:invalid_answer) } }.to_not change(@user.answers, :count)
      end
    end
  end

  describe 'PATCH #update' do
    before { get :edit, params: { question_id: question, id: answer } }

    context 'correct work' do
      it 'update object' do
        patch :update, params: { question_id: question, id: answer, answer: attributes_for(:answer) }
        expect(response).to redirect_to questions_path
      end

      it 'change attributes' do
        patch :update, question_id: question, id: answer, answer: { body: 'new body' }
        answer.reload
        expect(answer.body).to eq 'new body'
      end

      it 'render show view' do
        patch :update, question_id: question, id: answer, answer: { body: 'new body' }
        expect(response).to redirect_to questions_path
      end
    end

    context 'not correct work' do
      it 'not change attributes' do
        patch :update, question_id: question, id: answer, answer: { body: nil }
        answer.reload
        expect(answer.body).to eq 'MyText'
      end

      it 're-render edit view' do
        patch :update, question_id: question, id: answer, answer: { body: nil }
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroy answer' do
      answer
      expect { delete :destroy, params: { question_id: question, id: answer } }.to change(Answer, :count).by(-1)
    end

    it 'redirect to index view' do
      delete :destroy, params: { question_id: question, id: answer }
      expect(response).to redirect_to question
    end

    it 'user tries destroy not own answer' do
      expect { delete :destroy, params: { question_id: question, id: other_answer } }.to_not change(Answer, :count)
    end
  end
end
