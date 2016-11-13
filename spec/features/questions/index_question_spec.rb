require 'rails_helper'

feature 'User see list of questions', '
  I want to be able see questions
' do

  given(:user) { create(:user) }
  given(:question) { create(:question, user: user) }

  scenario 'Registrated user see list of questions' do
    sign_in(user)
    visit questions_path

    expect(question.title).to have_content 'MyString'
    expect(question.body).to have_content 'MyText'
  end
end
