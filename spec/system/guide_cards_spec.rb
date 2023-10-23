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

  describe 'nested SubGuides with display' do
    it 'shows the top-level guide with subguides underneath' do
      visit '/guide_cards/2869'
      expect(page).to have_text 'Bible'
      expect(page).to have_link 'Manuscripts'
      visit '/sub_guide_cards/1625'
      expect(page).to have_text 'Manuscripts'
    end
  end

  describe 'show page' do
    it 'displays card images as links' do
      CardImage.create(
        path: GuideCard.find(2).path,
        image_name: 'imagecat-disk1-0675-B1764-0000.0219.tif'
      )
      visit '/guide_cards/2'
      max_url = 'https://puliiif.princeton.edu/iiif/2/imagecat-disk1-0675-B1764-0000.0219/full/max/0/default.jpg'
      expect(page).to have_selector("a[href=\"#{max_url}\"] img[alt]")
    end

    context 'when there are no images' do
      it 'does not mention them' do
        visit '/guide_cards/2'
        expect(page).not_to have_text 'No cards found'
      end
    end
    context 'when it is an InfoCard' do
      it 'displays the .html snippet' do
        InfoCardLoadingService.new.import
        visit '/guide_cards/29378'
        expect(page).to have_content 'Because the United States file is so long'
        expect(page).not_to have_content '<p>'
      end
    end
  end

  context 'when a GuideCard has no SubGuide cards' do
    it 'does not show a subguide cards list heading' do
      visit '/guide_cards/2'
      expect(page).not_to have_text('SubGuide Cards')
    end
  end
end
