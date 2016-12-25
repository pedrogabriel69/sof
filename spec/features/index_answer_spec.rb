require_relative 'features_helper'

feature 'User see question and list of answers', '
  I want to be able see answers and question
' do

  let(:user) { create(:user) }
  let!(:question) { create(:question, user: user) }
  let!(:a1) { create(:answer, question: question, user: user) }
  let!(:a2) { create(:answer, question: question, user: user) }

  scenario 'Registrated user see question and list of answers' do
    sign_in(user)
    visit question_path(question)

    expect(page).to have_content(question.title)
    expect(page).to have_content(question.body)
    expect(page).to have_content(a1.body)
    expect(page).to have_content(a2.body)
  end
end
