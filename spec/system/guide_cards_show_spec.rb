# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GuideCards Show Page', type: :system, js: true do
  describe 'GuideCards show page' do
    let(:guide_card_fixture) { Rails.root.join('spec', 'fixtures', 'guide_card_fixture.csv') }
    before do
      GuideCardLoadingService.new(csv_location: guide_card_fixture).import
    end
    it 'displays images' do
      visit '/guide_cards/2'
      byebug
    end
  end
end
