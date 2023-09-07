# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Search Feature', type: :system, js: true do
  let(:guide_card_fixture) { Rails.root.join('spec', 'fixtures', 'guide_card_fixture.csv') }
  before do
    GuideCardLoadingService.new(csv_location: guide_card_fixture).import
  end

  describe 'search bar on front page' do
    it 'returns an index of GuideCards with search term indicated' do
      visit '/'
      fill_in 'search_term', with: 'AID'
      click_on 'Go'
      expect(page).to have_link('* AID')
    end
  end
end
