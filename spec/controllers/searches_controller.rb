require 'rails_helper'

RSpec.describe SearchesController, type: :controller do
  sign_in_user

  let(:question) { create(:question, title: 'Question title', body: 'Question body', user: @user) }

  describe 'POST #search' do
    before { post :search, params: { search: { type: 'Global', value: 'title' }, format: :js } }

    it 'implement search' do
      expect(response).to be_success
    end

    it 'render search view' do
      expect(response).to render_template :search
    end
  end
end
