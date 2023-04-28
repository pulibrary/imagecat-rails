require 'rails_helper'

RSpec.describe "GuideCards", type: :system do
  before do
    driven_by(:rack_test)
  end

  # describe "GuideCards index page" do
  #   it "displays pagination controls" do
  #     visit guide_cards_url
  #     expect(page).to have_link('Next', href: '/guide_cards?page=2')
  #   end
  # end
end
