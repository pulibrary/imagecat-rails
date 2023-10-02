# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GuideCards', type: :system, js: true do
  let(:guide_card_fixture) { Rails.root.join('spec', 'fixtures', 'guide_card_fixture.csv') }
  let(:subguide_card_fixture) { Rails.root.join('spec', 'fixtures', 'subguide_card_fixture.csv') }
  before do
    GuideCardLoadingService.new(csv_location: guide_card_fixture).import
    SubGuideLoadingService.new(csv_location: subguide_card_fixture,
                               progressbar: ProgressBar.create(output: ProgressBar::Outputs::Null)).import
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

  describe 'show page' do
    it 'displays card images' do
      ci = CardImage.new
      ci.path = GuideCard.find(2).path
      ci.image_name = 'imagecat-disk1-0675-B1764-0000.0219.tif'
      ci.save
      visit '/guide_cards/2'
      expect(page).to have_selector('img')
      expect(page).to have_selector('img[alt]')
    end
  end

  context 'when a GuideCard has no SubGuide cards' do
    it 'displays text to that effect' do
      visit '/guide_cards/2'
      expect(page).not_to have_text('SubGuide Cards')
    end
  end
end
