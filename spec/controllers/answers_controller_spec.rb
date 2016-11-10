require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:user) { create(:user) }
  let(:question) { create(:question, user: user) }
  let(:answer) { create(:answer, user: user, question: question) }

  describe 'GET #show' do
    before { get :show, params: { question_id: question, id: answer } }

    it 'show object' do
      expect(assigns(:answer)).to eq answer
    end

    it 'render show view' do
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    before { get :new, params: { question_id: question, id: answer } }

    it 'new object' do
      expect(assigns(:answer)).to be_a_new(Answer)
    end

    it 'render new view' do
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
    before { get :edit, params: { question_id: question, id: answer } }

    it 'edit object' do
      expect(assigns(:answer)).to eq answer
    end

    it 'render edit view' do
      expect(response).to render_template :edit
    end
  end

  describe 'POST #create' do
    context 'correct work' do
      it 'create object' do
        expect { post :create, question_id: question, user_id: user, answer: attributes_for(:answer) }.to change(Answer, :count).by(1)
      end

      it 'render show view' do
        post :create, question_id: question, user_id: user, answer: attributes_for(:answer)
        expect(response).to redirect_to questions_path
      end
    end

    context 'not correct work' do
      it 'create object' do
        expect { post :create, question_id: question, user_id: user, answer: attributes_for(:invalid_answer) }.to_not change(Answer, :count)
      end

      it 're-render new view' do
        post :create, question_id: question, user_id: user, answer: attributes_for(:invalid_answer)
        expect(response).to render_template :new
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
      expect(response).to redirect_to questions_path
    end
  end
end
