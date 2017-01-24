require 'rails_helper'

RSpec.describe FollowsController, type: :controller do
  sign_in_user

  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:question) { create(:question, user: user) }
  let(:follow) { create(:follow, user: @user, followable_id: question.id) }
  let(:other_follow) { create(:follow, user: other_user, followable_id: question.id) }

  describe 'POST #create' do
    context 'correct work' do
      it 'create object' do
        expect { post :create, params: { question_id: question.id, format: :js } }.to change(question.follows, :count).by(1).and change(@user.follows, :count).by(1)
      end

      it 'render show view' do
        post :create, params: { question_id: question, format: :js }
        expect(response).to render_template :create
      end
    end

    context "incorrrect work" do
      it 'user can not subscribe twice for one question' do
        expect { post :create, params: { question_id: question, format: :js } }.to change(question.follows, :count).by(1).and change(@user.follows, :count).by(1)
        expect { post :create, params: { question_id: question, format: :js } }.to_not change(question.follows, :count)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroy follow' do
      follow
      expect { delete :destroy, params: { question_id: question, id: follow, format: :js } }.to change(question.follows, :count).by(-1)
    end

    it 'user tries destroy not own follow' do
      other_follow
      expect { delete :destroy, params: { question_id: question, id: other_follow, format: :js } }.to_not change(question.follows, :count)
    end
  end
end
