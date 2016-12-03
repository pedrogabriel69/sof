require_relative 'features_helper'

feature 'User vote for question', '
  In order to change rating question,
  I want vote for question
' do

  given(:user) { create(:user) }
  given(:user_2) { create(:user) }
  given(:question) { create(:question, user: user_2) }

  scenario 'Authanticated user try to vote for own question', js: true do
    sign_in(user_2)

    visit question_path(question)

    within ".rating" do
      expect(page).to have_content "0"
    end

    find("a[href='#{like_question_path(question)}']").click

    expect(current_path).to eq question_path(question)
    within ".rating" do
      expect(page).to have_content "0"
    end
  end

  scenario 'Authanticated user try to vote for question', js: true do
    sign_in(user)

    visit question_path(question)

    within ".rating" do
      expect(page).to have_content "0"
    end

    find("a[href='#{like_question_path(question)}']").click

    expect(current_path).to eq question_path(question)
    within ".rating" do
      expect(page).to have_content "1"
    end
  end

  scenario 'Authanticated user try to vote for question twice', js: true do
    sign_in(user)

    visit question_path(question)

    within ".rating" do
      expect(page).to have_content "0"
    end

    find("a[href='#{like_question_path(question)}']").click

    expect(current_path).to eq question_path(question)
    within ".rating" do
      expect(page).to have_content "1"
    end

    find("a[href='#{like_question_path(question)}']").click

    expect(current_path).to eq question_path(question)
    within ".rating" do
      expect(page).to have_content "1"
    end
  end
end
