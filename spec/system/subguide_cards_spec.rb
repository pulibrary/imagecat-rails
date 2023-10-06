# frozen_string_literal: true

require 'rails_helper'
require 'ruby-progressbar/outputs/null'

RSpec.describe 'SubGuideCards', type: :system, js: true do
  let(:subguide_card_fixture) { Rails.root.join('spec', 'fixtures', 'subguide_card_fixture.csv') }
  before do
    SubGuideLoadingService.new(csv_location: subguide_card_fixture,
                               progressbar: ProgressBar.create(output: ProgressBar::Outputs::Null)).import
  end

  describe 'show page' do
    it 'displays card images' do
      ci = CardImage.new
      ci.path = SubGuideCard.find(2).path
      ci.image_name = 'imagecat-disk1-0675-B1764-0000.0219.tif'
      ci.save
      visit '/sub_guide_cards/2'
      expect(page).to have_selector('img')
      expect(page).to have_selector('img[alt]')
      expect(page).to have_content('Card 1 of 1')
    end

    it 'links to child SubGuideCards' do
      visit '/sub_guide_cards/4'
      expect(page).to have_link('(As author)')
    end
  end
end
