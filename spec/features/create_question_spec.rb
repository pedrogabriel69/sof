require_relative 'features_helper'

feature 'User create question', '
  I want to be able ask questions
' do

  given(:user) { create(:user) }
  given(:guest) { create(:user) }

  scenario 'Authenticated user creates question' do
    sign_in(user)

    visit questions_path
    click_on('Ask question')
    fill_in('Title', with: 'Test question')
    fill_in('Your question', with: 'body text')
    click_button 'Save'

    expect(page).to have_content 'Your question successfully created.'
  end

  scenario 'Non authenticated user try to create question' do
    visit new_question_path

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end

  context "multiple sessions, questions" do
    scenario "question appears on another user's page" do
      Capybara.using_session('user') do
        sign_in(user)
        visit questions_path
      end

      Capybara.using_session('guest') do
        sign_in(guest)
        visit questions_path
      end

      Capybara.using_session('user') do
        click_on('Ask question')
        fill_in('Title', with: 'Test question')
        fill_in('Your question', with: 'body text')
        click_button 'Save'

        expect(page).to have_content 'Test question'
        expect(page).to have_content 'body text'
      end

      Capybara.using_session('guest') do
        visit questions_path

        expect(page).to have_content 'Test question'
        expect(page).to have_content 'body text'
      end
    end
  end
end
