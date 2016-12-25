require_relative 'features_helper'

feature 'User create answer', '
  I want to be able ask answers
' do

  let(:user) { create(:user) }
  let(:guest) { create(:user) }
  let(:question) { create(:question, user: user) }

  scenario 'Authenticated user creates answer', js: true do
    sign_in(user)

    visit question_path(question)
    fill_in('Your answer', with: 'My Answer')
    click_button 'Save'

    expect(current_path).to eq question_path(question)
    within '.answers' do
      expect(page).to have_content user.name
      expect(page).to have_content 'My Answer'
    end
  end

  scenario 'User try to create invalid answer', js: true do
    sign_in(user)

    visit question_path(question)
    click_button 'Save'

    expect(page).to have_content "Body can't be blank"
  end

  context "multiple sessions, answers" do
    scenario "question appears on another user's page", js: true do
      Capybara.using_session('user') do
        sign_in(user)
        visit question_path(question)
      end

      Capybara.using_session('guest') do
        sign_in(guest)
        visit question_path(question)
      end

      Capybara.using_session('user') do
        fill_in('Your answer', with: 'My Answer')
        click_button 'Save'

        expect(current_path).to eq question_path(question)
        within '.answers' do
          expect(page).to have_content user.name
          expect(page).to have_content 'My Answer'
        end
      end

      Capybara.using_session('guest') do
        visit question_path(question)

        within '.answers' do
          expect(page).to have_content user.name
          expect(page).to have_content 'My Answer'
        end
      end
    end
  end
end
