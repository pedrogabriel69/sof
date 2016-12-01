require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  it_behaves_like "voted" do
    let(:question) { create(:question, user: user) }
    let(:votable) { create(:answer, user: user, question: question) }
    let(:params_votable) { { question_id: question, id: votable } }
  end

  sign_in_user

  let(:question) { create(:question, user: @user) }
  let(:answer) { create(:answer, user: @user, question: question, flag: false) }

  let(:user) { create(:user, email: 'test@test.io') }
  let!(:other_answer) { create(:answer, user: user, question: question) }

  let(:new_question) { create(:question, user: user) }
  let!(:new_answer) { create(:answer, user: user, question: new_question) }

  describe 'POST #create' do
    context 'correct work' do
      it 'create object' do
        expect { post :create, params: { user_id: @user, question_id: question, answer: attributes_for(:answer), format: :js } }.to change(question.answers, :count).by(1)
        expect { post :create, params: { user_id: @user, question_id: question, answer: attributes_for(:answer), format: :js } }.to change(@user.answers, :count).by(1)
      end

      it 'render show view' do
        post :create, params: { user_id: @user, question_id: question, answer: attributes_for(:answer), format: :js }
        expect(response).to render_template :create
      end
    end

    context 'not correct work' do
      it 'create object' do
        expect { post :create, params: { question_id: question, user_id: @user, answer: attributes_for(:invalid_answer), format: :js } }.to_not change(question.answers, :count)
        expect { post :create, params: { question_id: question, user_id: @user, answer: attributes_for(:invalid_answer), format: :js } }.to_not change(@user.answers, :count)
      end
    end
  end

  describe 'PATCH #update' do
    context 'correct work' do
      it 'update object' do
        patch :update, params: { question_id: question, id: answer, answer: attributes_for(:answer), format: :js }
        expect(assigns(:answer)).to eq answer
      end

      it 'change attributes' do
        patch :update, question_id: question, id: answer, answer: { body: 'new body' }, format: :js
        answer.reload
        expect(answer.body).to eq 'new body'
      end
    end

    context 'not correct work' do
      it 'not change attributes' do
        patch :update, question_id: question, id: answer, answer: { body: nil }, format: :js
        answer.reload
        expect(answer.body).to eq 'My Answer'
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroy answer' do
      answer
      expect { delete :destroy, params: { question_id: question, id: answer, format: :js } }.to change(Answer, :count).by(-1)
    end

    it 'user tries destroy not own answer' do
      expect { delete :destroy, params: { question_id: question, id: other_answer, format: :js } }.to_not change(Answer, :count)
    end
  end

  describe 'BEST #PUT' do
    it 'choose best answer' do
      expect(answer.flag).to be false
      put :best, question_id: question, id: answer, format: :js
      answer.reload
      expect(answer.flag).to be true
    end

    it 'Not author try to choose best answer' do
      expect(new_answer.flag).to be false
      put :best, question_id: new_question, id: new_answer, format: :js
      answer.reload
      expect(new_answer.flag).to be false
    end
  end
end
