# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GuideCards', type: :system, js: true do
  let(:guide_card_fixture) { Rails.root.join('spec', 'fixtures', 'guide_card_fixture.csv') }
  let(:subguide_card_fixture) { Rails.root.join('spec', 'fixtures', 'subguide_card_fixture.csv') }
  before do
    GuideCardLoadingService.new(csv_location: guide_card_fixture).import
    SubGuideLoadingService.new(csv_location: subguide_card_fixture).import
  end

  describe 'GuideCards index page' do
    it 'displays pagination controls' do
      visit '/guide_cards'
      expect(page).to have_link('Next', href: '/guide_cards?page=2')
      click_link('Next')
      expect(page).to have_link('A.M.')
    end
  end

  describe 'nested SubGuides with image display' do
    it 'shows the top-level guide with subguides underneath' do
      visit '/guide_cards/2869'
      expect(page).to have_text 'Bible'
      expect(page).to have_link 'Manuscripts'
      visit '/sub_guide_cards/1625'
      expect(page).to have_text 'Manuscripts'
    end
  end
end
