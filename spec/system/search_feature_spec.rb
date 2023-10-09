# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Search Feature', type: :system, js: true do
  let(:guide_card_fixture) { Rails.root.join('spec', 'fixtures', 'guide_card_search_fixture.csv') }
  before do
    GuideCardLoadingService.new(csv_location: guide_card_fixture).import
  end

  describe 'search bar on front page' do
    it 'returns an index of GuideCards with search term indicated and it paginates' do
      visit '/'
      fill_in 'search_term', with: 'Aaron'
      click_on 'Go'
      expect(page).to have_link('* Aaron')
      click_on '3'
      expect(page).to have_link('Abaza')
    end
    it 'finds the closest match if there is no exact match' do
      visit '/'
      fill_in 'search_term', with: 'Aarons'
      click_on 'Go'
      expect(page).to have_link('* Aaron')
    end
    it 'allows navigation back to page 1' do
      visit '/'
      fill_in 'search_term', with: 'Aaron'
      click_on 'Go'
      expect(page).to have_link('* Aaron')
      click_on '1'
      expect(page).to have_link('AALAS')
    end
    it 'ignores capitalization' do
      visit '/'
      fill_in 'search_term', with: 'aaron'
      click_on 'Go'
      expect(page).to have_link('* Aaron')
    end
  end
end
