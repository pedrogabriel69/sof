require_relative 'features_helper'

feature 'User see list of questions', '
  I want to be able see questions
' do

  let(:user) { create(:user) }
  let!(:q1) { create(:question, user: user) }
  let!(:q2) { create(:question, user: user) }

  scenario 'Registrated user see list of questions' do
    sign_in(user)
    visit questions_path

    expect(page).to have_content(q1.title)
    expect(page).to have_content(q1.body)
    expect(page).to have_content(q2.title)
    expect(page).to have_content(q2.body)
  end
end
