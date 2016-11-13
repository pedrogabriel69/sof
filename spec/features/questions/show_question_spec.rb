require 'rails_helper'

feature 'User see question with answers', '
  I want to be able see question with answers
' do

  given(:user) { create(:user) }
  given(:question) { create(:question, user: user) }
  given(:answer) { create(:answer, user: user, question: question) }

  scenario 'Authenticated user creates question' do
    sign_in(user)

    visit question_path(question)

    expect(question.title).to have_content 'MyString'
    expect(question.body).to have_content 'MyText'
    expect(answer.question.body).to have_content 'MyText'
  end
end
