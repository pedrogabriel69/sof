require 'rails_helper'

feature 'User sign in', %q{
  For checking sing in
} do

  scenario 'Registrated User try to sign in' do
    User.create(email: 'example@example.com', password: '1qwerty')

    visit new_user_session_path
    fill_in 'Email', with: 'example@example.com'
    fill_in 'Password', with: '1qwerty'
    click_on 'Sign in'

    expect(page).to have_content 'Signed in successfully.'
    expect(current_path).to eq root_path
  end

  scenario 'Not registrated User try to sign in' do
    visit new_user_session_path
    fill_in 'Email', with: 'wrong@example.com'
    fill_in 'Password', with: '111qwerty'
    click_on 'Sign in'

    expect(page).to have_content 'Invalid Email or password.'
    expect(current_path).to eq new_user_session_path
  end
end
