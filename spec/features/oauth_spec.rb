require_relative 'features_helper'

feature 'User sign in with other providers', '
  I want to be able sign in with twitter and facebook
' do

  before do
    OmniAuth.config.test_mode = true
    visit root_path
  end

  describe 'sign in with Twitter' do
    before do
      click_on 'Sign in'
      mock_auth_hash(:twitter)
    end

    describe 'add email' do
      before { click_on 'Sign in with Twitter' }

      scenario 'successfuly sign in twitter' do
        fill_in "Can't be empty", with: 'test@test.io'
        click_on 'Save'
        expect(page).to have_content 'You have to confirm your email address before continuing.'

        open_email('test@test.io')
        expect(current_email).to have_content('Confirm my account')
        current_email.click_link 'Confirm my account'

        click_on 'Sign in with Twitter'
        expect(page).to have_content 'Successfully authenticated from twitter account.'
      end
    end

    scenario 'invalid credentials' do
      OmniAuth.config.mock_auth[:twitter] = :invalid_credentials
      click_on 'Sign in with Twitter'
      expect(page).to have_content 'Could not authenticate you from Twitter because "Invalid credentials"'
    end
  end

  describe 'sign in with Facebook' do
    before do
      click_on 'Sign in'
      mock_auth_hash(:facebook)
    end

    describe 'sign in facebook' do
      before { click_on 'Sign in with Facebook' }

      scenario 'successfuly sign in facebook' do
        open_email('test@test.io')
        expect(current_email).to have_content('Confirm my account')
        current_email.click_link 'Confirm my account'

        click_on 'Sign in with Facebook'
        expect(page).to have_content 'Successfully authenticated from facebook account.'
      end
    end

    scenario 'invalid credentials' do
      OmniAuth.config.mock_auth[:facebook] = :invalid_credentials
      click_on 'Sign in with Facebook'
      expect(page).to have_content 'Could not authenticate you from Facebook because "Invalid credentials"'
    end
  end
end
