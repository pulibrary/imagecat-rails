# frozen_string_literal: true

require 'rails_helper'
require 'ruby-progressbar/outputs/null'

RSpec.describe 'GuideCards', type: :system, js: true do
  let(:subguide_card_fixture) { Rails.root.join('spec', 'fixtures', 'subguide_card_fixture.csv') }
  before do
    SubGuideLoadingService.new(csv_location: subguide_card_fixture,
                               progressbar: ProgressBar.create(output: ProgressBar::Outputs::Null)).import
  end

  describe 'SubGuide page with image display' do
    it 'shows all images for the SubGuide path' do

      visit '/sub_guide_cards/2'
      expect(page).to have_text 'Afdeling natuurkunde'
    end
  end
end
