require 'rails_helper'

feature 'User create question', '
  I want to be able ask questions
' do

  given(:user) { create(:user) }

  scenario 'Authenticated user creates question' do
    sign_in(user)

    visit questions_path
    first(:link, 'MyString, ask question').click
    fill_in('Title', with: 'Test question')
    fill_in('Body', with: 'body text')
    click_button 'Save'

    expect(page).to have_content 'Your question successfully created.'
  end

  scenario 'Non authenticated user try to create question' do
    visit new_question_path

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end
