require_relative 'features_helper'

feature 'User sign in', '
  For checking sing in
' do

  given(:user) { create(:user) }

  scenario 'Registrated User try to sign in' do
    sign_in(user)

    expect(page).to have_content 'Signed in successfully.'
    expect(current_path).to eq root_path
  end

  scenario 'Not registrated User try to sign in' do
    visit new_user_session_path
    fill_in 'Email', with: 'wrong@example.com'
    fill_in 'Password', with: '123qwerty123'
    click_button 'Sign in'

    expect(page).to have_content 'Invalid Email or password.'
    expect(current_path).to eq new_user_session_path
  end
end
