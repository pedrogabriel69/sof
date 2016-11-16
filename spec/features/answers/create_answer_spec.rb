require 'features_helper'

feature 'User create question', '
  I want to be able ask questions
' do

  given(:user) { create(:user) }
  given(:question) { create(:question, user: user) }

  scenario 'Authenticated user creates answer', js: true do
    sign_in(user)

    visit question_path(question)
    fill_in('Your answer', with: 'My Answer')
    click_button 'Save'

    expect(current_path).to eq question_path(question)
    within '.answers' do
      expect(page).to have_content user.name
      expect(page).to have_content 'My Answer'
    end
  end
end
