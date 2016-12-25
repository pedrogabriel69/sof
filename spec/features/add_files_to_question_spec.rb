require_relative 'features_helper'

feature 'Add files to question', '
  I need attach files to my questions
' do

  let(:user) { create(:user) }

  before do
    sign_in(user)
    click_on('Ask question')
  end

  scenario 'User try to add file to question', js: true do
    fill_in('Title', with: 'Test question')
    fill_in('Your question', with: 'body text')
    click_on 'Attach file'
    attach_file("File", "#{Rails.root}/spec/spec_helper.rb")
    click_button 'Save'

    expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachment/file/1/spec_helper.rb'
  end
end
