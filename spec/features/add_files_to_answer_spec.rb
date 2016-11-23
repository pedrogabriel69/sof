require_relative 'features_helper'

feature 'Add files to answer', '
  I need attach files to my answers
' do

  given(:user) { create(:user) }
  given(:question) { create(:question, user: user) }

  background do
    sign_in(user)
    visit question_path(question)
  end

  scenario 'User try to add file to answer', js: true do
    fill_in('Your answer', with: 'My Answer')

    attach_file("File", "#{Rails.root}/spec/spec_helper.rb")
    click_button 'Save'
    within '.answers' do
      expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachment/file/1/spec_helper.rb'
    end
  end
end
