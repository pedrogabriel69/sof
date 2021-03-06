require_relative 'features_helper'

feature 'User see question with answers', '
  I want to be able see question with answers
' do

  let(:user) { create(:user) }
  let(:question) { create(:question, user: user) }

  scenario 'Authenticated user creates question' do
    sign_in(user)

    visit question_path(question)

    expect(page).to have_content(question.title)
    expect(page).to have_content(question.body)
  end
end
