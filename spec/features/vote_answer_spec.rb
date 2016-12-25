require_relative 'features_helper'

feature 'User vote for answer', '
  In order to change rating answer,
  I want vote for answer
' do

  let(:user) { create(:user) }
  let(:user_2) { create(:user) }
  let(:question) { create(:question, user: user_2) }
  let!(:answer) { create(:answer, question: question, user: user_2) }

  scenario 'Authanticated user try to vote for own answer', js: true do
    sign_in(user_2)

    visit question_path(question)

    within "#rating_#{answer.id}" do
      expect(page).to have_content "0"
    end

    find("a[href='#{like_question_answer_path(question, answer)}']").click

    expect(current_path).to eq question_path(question)
    within "#rating_#{answer.id}" do
      expect(page).to have_content "0"
    end
  end

  scenario 'Authanticated user try to vote for answer', js: true do
    sign_in(user)

    visit question_path(question)

    within "#rating_#{answer.id}" do
      expect(page).to have_content "0"
    end

    find("a[href='#{like_question_answer_path(question, answer)}']").click

    expect(current_path).to eq question_path(question)
    within "#rating_#{answer.id}" do
      expect(page).to have_content "1"
    end
  end

  scenario 'Authanticated user try to vote for answer twice', js: true do
    sign_in(user)

    visit question_path(question)

    within "#rating_#{answer.id}" do
      expect(page).to have_content "0"
    end

    find("a[href='#{like_question_answer_path(question, answer)}']").click

    expect(current_path).to eq question_path(question)
    within "#rating_#{answer.id}" do
      expect(page).to have_content "1"
    end

    find("a[href='#{like_question_path(question)}']").click

    expect(current_path).to eq question_path(question)
    within "#rating_#{answer.id}" do
      expect(page).to have_content "1"
    end
  end
end
