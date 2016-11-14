require 'rails_helper'

feature 'User see list of questions', '
  I want to be able see questions
' do

  given(:user) { create(:user) }
  given!(:q1) { create(:question, user: user) }
  given!(:q2) { create(:question, user: user) }

  scenario 'Registrated user see list of questions' do
    sign_in(user)
    visit questions_path

    expect(page).to have_content 'MyString MyText Edit | Delete MyString MyText Edit | Delete'
  end
end
