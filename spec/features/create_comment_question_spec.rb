require_relative 'features_helper'

feature 'User create comment to question', '
  I want to be able add comments to question
' do

  given(:user) { create(:user) }
  given(:guest) { create(:user) }
  given(:question) { create(:question, user: user) }

  scenario 'Authenticated user creates comment to question', js: true do
    sign_in(user)

    visit question_path(question)

    page.find(".question-comment-link").click
    fill_in('Your comment', with: 'My Comment')
    within '.simple_form.new_comment' do
      click_button 'Save'
    end

    expect(current_path).to eq question_path(question)
    within '.comments' do
      expect(page).to have_content 'My Comment'
    end
  end

  scenario 'User try to create invalid comment to question', js: true do
    sign_in(user)

    visit question_path(question)

    page.find(".question-comment-link").click
    within '.simple_form.new_comment' do
      click_button 'Save'
    end

    expect(page).to have_content "Body can't be blank"
  end

  context "multiple sessions, comment to question" do
    scenario "comment appears on another user's page", js: true do
      Capybara.using_session('user') do
        sign_in(user)
        visit question_path(question)
      end

      Capybara.using_session('guest') do
        sign_in(guest)
        visit question_path(question)
      end

      Capybara.using_session('user') do
        page.find(".question-comment-link").click
        fill_in('Your comment', with: 'My Comment')
        within '.simple_form.new_comment' do
          click_button 'Save'
        end

        expect(current_path).to eq question_path(question)
        within '.comments' do
          expect(page).to have_content 'My Comment'
        end
      end

      Capybara.using_session('guest') do
        visit question_path(question)

        within '.comments' do
          expect(page).to have_content 'My Comment'
        end
      end
    end
  end
end
