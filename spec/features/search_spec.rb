require_relative 'features_helper'

feature 'Search' do
  let(:user) { create(:user) }
  let!(:question) { create(:question, title: 'Title', body: 'Sphinx, RSpec, Rails', user: user) }

  scenario 'User implements search', js: true do
    visit search_path

    within ".search" do
      select "Global", :from => "Choose type"
      fill_in 'Add something...', with: 'Sphinx, RSpec, Rails'
      click_on 'Search'
    end

    expect(page).to have_content "Sphinx, RSpec, Rails"
  end

  scenario 'User implements search and no matches', js: true do
    visit search_path

    within ".search" do
      select "Global", :from => "Choose type"
      fill_in 'Add something...', with: 'JS'
      click_on 'Search'
    end

    expect(page).to have_content "Your search returned no matches."
  end
end
