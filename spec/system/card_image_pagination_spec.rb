# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Card Images Pagination', type: :system, js: true do
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

  describe 'GuideCards show page' do
    it 'displays and paginates through card images' do
      visit '/guide_cards/2'
      expect(page.all('div#main-content ul img').count).to eq 10
      within(page.all('ul#card_image_list li').last) do |last_li|
        expect(last_li.find('img')['src']).to match(/fake_image_10.jpg/)
        expect(last_li).to have_content 'Card 10 of 21'
      end
      expect(page).to have_link('Next', href: '/guide_cards/2?page=2')
      click_link('Next')
      expect(page.all('div#main-content ul img')[3][:src]).to match(/fake_image_14.jpg/)
      within(page.all('ul#card_image_list li')[3]) do |last_li|
        expect(last_li.find('img')['src']).to match(/fake_image_14.jpg/)
        expect(last_li).to have_content 'Card 14 of 21'
      end
    end
  end
end
