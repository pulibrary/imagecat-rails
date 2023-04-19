# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GuideCards', type: :request do
  let(:guide_card_fixture) { Rails.root.join('spec', 'fixtures', 'guide_card_fixture.csv') }
  before do
    GuideCardLoadingService.new(csv_location: guide_card_fixture).import
  end
  describe 'GET index' do
    it 'returns http success' do
      get '/guide_cards/'
      expect(response).to have_http_status(:success)
      expect(response.body).to include('AALAS')
      expect(response.body).to include('A.B.C.')
      expect(response.body).to include('A.C.I.')
    end
  end

  describe 'GET show' do
    it 'shows the metadata for a specific item' do
      get '/guide_cards/3'
      expect(response.body).to include('AALAS')
      expect(response.body).to include('3.5')
      expect(response.body).to include('14/0001/A1002')
    end
  end
end

# tests for HTTP network requests
