require_relative 'features_helper'

feature 'User edit answer', '
  I want to be able edit answer
' do

  given(:user) { create(:user) }
  given(:new_user) { create(:user) }
  given(:question) { create(:question, user: user) }
  given!(:answer) { create(:answer, user: user, question: question, body: '1') }
  given!(:answer_2) { create(:answer, user: new_user, question: question, body: '2') }
  given!(:answer_3) { create(:answer, user: new_user, question: question, body: '3') }

  scenario 'Not registrated user try to choose best answer' do
    visit question_path(question)

    expect(current_path).to eq question_path(question)
    expect(page).to_not have_link 'Best'
  end

  scenario 'Authenticated user try to choose best answer not to his question', js: true do
    sign_in(new_user)

    visit question_path(question)

    expect(current_path).to eq question_path(question)
    expect(page).to_not have_link 'Best'
  end

  scenario 'Authenticated user try to choose best answer to his question', js: true do
    sign_in(user)

    visit question_path(question)

    within "#answer_#{answer_3.id}" do
      click_link('Best')
    end

    expect(current_path).to eq question_path(question)
    # I don't know how to check that answer replace his position on page?
  end
end
