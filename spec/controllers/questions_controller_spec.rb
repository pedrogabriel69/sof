require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  sign_in_user
  let(:question) { create(:question, title: 'Question title', body: 'Question body', user: @user) }

  let(:user) { create(:user, email: 'test@test.io') }
  let!(:other_question) { create(:question, user: user) }

  describe 'GET #index' do
    let(:q1) { create(:question, user: @user) }
    let(:q2) { create(:question, user: @user) }

    before { get :index }

    it 'show all objects' do
      expect(assigns(:questions)).to match_array([q1, q2, other_question])
    end

    it 'render index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    before { get :show, params: { id: question } }

    it 'show object' do
      expect(assigns(:question)).to eq question
    end

    it 'assigns new user for question' do
      expect(assigns(:answer)).to be_a_new(Answer)
    end

    it 'render show view' do
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    before { get :new }

    it 'new object' do
      expect(assigns(:question)).to be_a_new(Question)
    end

    it 'build new attachment for question' do
      expect(assigns(:question).attachments.first).to be_a_new(Attachment)
    end

    it 'render new view' do
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
    before { get :edit, params: { id: question } }

    it 'edit object' do
      expect(assigns(:question)).to eq question
    end

    it 'render edit view' do
      expect(response).to render_template :edit
    end
  end

  describe 'POST #create' do
    context 'correct work' do
      it 'create object' do
        expect { post :create, user_id: @user, params: { question: attributes_for(:question) } }.to change(@user.questions, :count).by(1)
      end

      it 'render show view' do
        post :create, user_id: @user, params: { question: attributes_for(:question) }
        expect(response).to redirect_to question_path(assigns(:question))
      end
    end

    context 'not correct work' do
      it 'create object' do
        expect { post :create, user_id: @user, params: { question: attributes_for(:invalid_question) } }.to_not change(@user.questions, :count)
      end
    end
  end

  describe 'PATCH #update' do
    before { get :edit, params: { id: question } }

    context 'correct work' do
      it 'update object' do
        patch :update, params: { id: question, question: attributes_for(:question) }
        expect(assigns(:question)).to eq question
      end

      it 'change attributes' do
        patch :update, id: question, question: { title: 'new title', body: 'new body' }
        question.reload
        expect(question.title).to eq 'new title'
        expect(question.body).to eq 'new body'
      end

      it 'render show view' do
        patch :update, id: question, question: { title: 'new title', body: 'new body' }
        expect(response).to redirect_to question
      end
    end

    context 'not correct work' do
      it 'not change attributes' do
        patch :update, id: question, question: { title: 'new title', body: nil }
        question.reload
        expect(question.title).to eq 'Question title'
        expect(question.body).to eq 'Question body'
      end

      it 're-render edit view' do
        patch :update, id: question, question: { title: 'new title', body: nil }
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroy question' do
      question
      expect { delete :destroy, params: { id: question } }.to change(Question, :count).by(-1)
    end

    it 'redirect to index view' do
      delete :destroy, params: { id: question }
      expect(response).to redirect_to questions_path
    end

    it 'user tries destroy not own question' do
      expect { delete :destroy, params: { id: other_question } }.to_not change(Question, :count)
    end
  end
end
