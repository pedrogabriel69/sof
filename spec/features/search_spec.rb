require_relative 'features_helper'

feature 'Search' do
  let(:user) { create(:user) }
  let!(:question) { create(:question, title: 'Title', body: 'Sphinx, RSpec, Rails', user: user) }

  before do
    index
    visit search_path
  end

  scenario 'Success, user implements search', js: true do
    within ".search" do
      select "Global", from: "Choose type"
      fill_in 'Add something...', with: 'Sphinx, RSpec, Rails'
      click_on 'Search'
    end

    expect(page).to have_content "Sphinx, RSpec, Rails"
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
