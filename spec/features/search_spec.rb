require_relative 'features_helper'

feature 'Search' do
  let!(:user) { create(:user, name: 'test_user', email: 'user@test.io') }
  let!(:question) { create(:question, title: 'Title', body: 'm?@sk$-"ny', user: user) }
  let!(:answer) { create(:answer, user: user, question: question, body: 'Answer') }
  let!(:comment) { create(:comment, user: user, commentable_id: answer.id, commentable_type: 'Answer', body: 'Comment to A') }

  before do
    index
    visit search_path
  end

  context 'Success, user implements search' do
    scenario 'Type: Global', js: true do
      within ".search" do
        select "Global", from: "Choose type"
        fill_in 'Add something...', with: 'm?@sk$-"ny'
        click_on 'Search'
      end

      expect(page).to have_content 'm?@sk$-"ny'
    end

    scenario 'Type: Question', js: true do
      within ".search" do
        select "Question", from: "Choose type"
        fill_in 'Add something...', with: question.body
        click_on 'Search'
      end

      expect(page).to have_content "Question"
    end

    scenario 'Type: Answer', js: true do
      within ".search" do
        select "Answer", from: "Choose type"
        fill_in 'Add something...', with: answer.body
        click_on 'Search'
      end

      expect(page).to have_content "Answer"
    end

    scenario 'Type: Comment', js: true do
      within ".search" do
        select "Comment", from: "Choose type"
        fill_in 'Add something...', with: comment.body
        click_on 'Search'
      end

      expect(page).to have_content "Comment"
    end

    scenario 'Type: User', js: true do
      within ".search" do
        select "User", from: "Choose type"
        fill_in 'Add something...', with: user.name
        click_on 'Search'
      end

      expect(page).to have_content "test_user"
    end

    scenario 'searching by full email address', js: true do
      within ".search" do
        select "Global", from: "Choose type"
        fill_in 'Add something...', with: user.email
        click_on 'Search'
      end

      expect(page).to have_content "user@test.io"
    end
  end

  scenario 'Fail, user implements search', js: true do
    within ".search" do
      select "Global", from: "Choose type"
      fill_in 'Add something...', with: 'JS'
      click_on 'Search'
    end

    expect(page).to have_content "Your search returned no matches."
  end
end
