# frozen_string_literal: true

require 'rails_helper'

describe 'accessibility', type: :system, js: true do
  context 'home page' do
    it 'complies with WCAG' do
      visit '/'

      expect(page).to be_axe_clean
        .according_to(:wcag2a, :wcag2aa, :wcag21a, :wcag21aa)
    end
  end

  context 'search results' do
    it 'complies with WCAG' do
      visit 'search?search_term=?&commit=Go'

      expect(page).to be_axe_clean
        .according_to(:wcag2a, :wcag2aa, :wcag21a, :wcag21aa)
    end
  end

  context 'guide cards' do
    let(:guide_card_fixture) { Rails.root.join('spec', 'fixtures', 'guide_card_fixture.csv') }
    before do
      GuideCardLoadingService.new(csv_location: guide_card_fixture).import
      (1..21).each do |i|
        ci = CardImage.new
        ci.path = '14/0001/B4491'
        ci.image_name = "fake_image_#{i}.jpg"
        ci.save
      end
    end

    it 'complies with WCAG' do
      visit '/guide_cards/2'

      expect(page).to be_axe_clean
        .according_to(:wcag2a, :wcag2aa, :wcag21a, :wcag21aa)
    end
  end
end
