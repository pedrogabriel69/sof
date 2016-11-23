require_relative 'features_helper'

feature 'Add files to question', '
  I need attach files to my questions
' do

  given(:user) { create(:user) }

  background do
    sign_in(user)
    click_on('Ask question')
  end

  scenario 'User try to add file to question' do
    fill_in('Title', with: 'Test question')
    fill_in('Your question', with: 'body text')
    attach_file("File", "#{Rails.root}/spec/spec_helper.rb")
    click_button 'Save'

    expect(page).to have_content 'spec_helper.rb'
  end
end
