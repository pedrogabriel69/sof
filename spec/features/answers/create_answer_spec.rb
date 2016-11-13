require 'rails_helper'

feature 'User create question', '
  I want to be able ask questions
' do

  given(:user) { create(:user) }
  given(:question) { create(:question, user: user) }

  scenario 'Authenticated user creates question' do
    sign_in(user)

    visit question_path(question)
    fill_in('Your answer', with: 'body text')
    click_button 'Save'

    expect(question.answers.last.user).to eq user
    expect(question.answers.last.body).to have_content 'body text'
  end
end
