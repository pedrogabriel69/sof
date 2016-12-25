require_relative 'features_helper'

feature 'User sign out', '
  For checking sing out
' do

  let(:user) { create(:user) }

  scenario 'Registrated User try to sign in' do
    sign_in(user)
    sign_out(user)

    expect(page).to have_content 'Signed out successfully.'
    expect(current_path).to eq root_path
  end
end
