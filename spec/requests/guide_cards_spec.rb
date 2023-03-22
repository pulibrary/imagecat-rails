# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GuideCards', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      get '/guide_cards/index'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      get '/guide_cards/show'
      expect(response).to have_http_status(:success)
    end
  end
end
