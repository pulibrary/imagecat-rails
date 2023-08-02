# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GuideCards', type: :system, js: true do
  let(:guide_card_fixture) { Rails.root.join('spec', 'fixtures', 'guide_card_fixture.csv') }
  before do
    GuideCardLoadingService.new(csv_location: guide_card_fixture).import
  end

  describe 'GuideCards index page' do
    it 'displays pagination controls' do
      visit '/guide_cards'
      expect(page).to have_link('Next', href: '/guide_cards?page=2')
      click_link('Next')
      expect(page).to have_link('A.M.')
    end
  end

  describe 'GuideCards show page' do
    it 'displays children SubGuide cards' do
      SubGuideCard.create(parentid: GuideCard.find(3).sortid, heading: 'Institut fizicheskoi >')
      visit '/guide_cards/3'
      expect(page).to have_text 'Institut fizicheskoi >'
    end
  end
end
