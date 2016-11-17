require_relative 'features_helper'

feature 'User edit answer', '
  I want to be able edit answer
' do

  given(:user) { create(:user) }
  given(:new_user) { create(:user) }
  given(:question) { create(:question, user: user) }
  given!(:answer) { create(:answer, user: new_user, question: question) }

  scenario 'Not registrated user try edit answer' do
    visit question_path(question)

    expect(current_path).to eq question_path(question)
    expect(page).to_not have_link 'Edit'
  end

  scenario 'User edit answer' do
    sign_in(new_user)

    visit question_path(question)
    click_link('Edit')
    fill_in('Your answer', with: 'My New Answer')
    click_button 'Edit'

    expect(current_path).to eq question_path(question)
    within '.answers' do
      expect(page).to have_content new_user.name
      expect(page).to have_content 'My New Answer'
      expect(page).to_not have_content 'My Answer'
    end
  end

  scenario 'User try to edit invalid answer' do
    sign_in(new_user)

    visit question_path(question)
    click_link('Edit')
    fill_in('Your answer', with: '')
    click_button 'Edit'

    expect(page).to have_content "Body can't be blank"
  end
end
