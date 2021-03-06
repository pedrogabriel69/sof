require_relative 'features_helper'

feature 'User sign up', '
  For checking sing up
' do

  before do
    allow(RegistrationsController.new).to receive(:verify_recaptcha).and_return(true)
  end

  scenario 'User try to sign up, success' do
    visit new_user_registration_path
    fill_in('Username', with: 'user')
    fill_in('Email', with: 'user@user.io')
    fill_in('Password', with: '123456789')
    fill_in('Password confirmation', with: '123456789')
    click_button 'Sign up'

    expect(page).to have_content 'A message with a confirmation link has been sent to your email address. Please follow the link to activate your account.'
    expect(current_path).to eq root_path
  end

  scenario 'User try to sign up, fail' do
    visit new_user_registration_path
    fill_in('Username', with: 'user')
    fill_in('Email', with: 'user@user.io')
    fill_in('Password', with: '123456789')
    fill_in('Password confirmation', with: '1234567890')
    click_button 'Sign up'

    expect(page).to have_content "Password confirmation doesn't match Password"
    expect(current_path).to eq '/users'
  end
end
