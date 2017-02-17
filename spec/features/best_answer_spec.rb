require_relative 'features_helper'

feature 'User edit answer', '
  I want to be able edit answer
' do

  let(:user) { create(:user) }
  let(:new_user) { create(:user) }
  let(:question) { create(:question, user: user) }
  let!(:answer) { create(:answer, user: user, question: question, body: 'My Answer 1') }
  let!(:answer_2) { create(:answer, user: new_user, question: question, body: 'My Answer 2') }

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

    within "#answer_#{answer_2.id}" do
      find('.glyphicon-star-empty').trigger('click')
    end

    expect(current_path).to eq question_path(question)
    within ".answers > div:first-child" do
      expect(page).to have_content "My Answer 2"
    end
  end
end
