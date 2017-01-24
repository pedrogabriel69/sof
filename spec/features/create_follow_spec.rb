require_relative 'features_helper'

feature 'User create subscribe to question', '
  I want to be able subscribe to question
' do

  let(:user) { create(:user, email: 'test@test.io') }
  let(:other_user) { create(:user) }
  let!(:question) { create(:question, user: other_user) }

  scenario 'Authenticated user subscribe/unsubscribe to question', js: true do
    sign_in(user)

    visit question_path(question)

    click_on('Subscribe')
    expect(page).to have_link 'Unsubscribe'

    click_on('Unsubscribe')
    expect(page).to have_link 'Subscribe'
  end
end
