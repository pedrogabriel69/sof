require 'rails_helper'

feature 'User see question and list of answers', '
  I want to be able see answers and question
' do

  given(:user) { create(:user) }
  given!(:question) { create(:question, user: user) }
  given!(:a1) { create(:answer, question: question, user: user) }
  given!(:a2) { create(:answer, question: question, user: user) }

  scenario 'Registrated user see question and list of answers' do
    sign_in(user)
    visit question_path(question)

    expect(page).to have_content(question.title)
    expect(page).to have_content(question.body)
    expect(page).to have_content(a1.body)
    expect(page).to have_content(a2.body)
  end
end
