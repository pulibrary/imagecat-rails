# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Card Images Pagination', type: :system, js: true do
  let(:guide_card_fixture) { Rails.root.join('spec', 'fixtures', 'guide_card_fixture.csv') }
  before do
    GuideCardLoadingService.new(csv_location: guide_card_fixture).import
    for i in 1..21 do 
      ci = CardImage.new
      ci.path = '14/0001/B4491'
      ci.image_name = "fake_image_#{i}.jpg"
      ci.save
    end
  end

  describe 'GuideCards show page' do
    it 'displays and paginates through card images' do
      visit '/guide_cards/2'
      expect(page).to have_link('Next', href: '/guide_cards/2?page=2')
      click_link('Next')
    end
  end
end
