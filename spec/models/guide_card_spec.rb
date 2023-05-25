# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GuideCard, type: :model do
  it 'has the GuideCard fields' do
    guidecard = GuideCard.new
    guidecard.id = 2
    guidecard.heading = 'A'
    guidecard.sortid = '2.5'
    guidecard.path = '14/0001/B4491'
    guidecard.save
    expect(guidecard.id).to eq 2
    expect(guidecard.heading).to eq 'A'
    expect(guidecard.sortid).to eq '2.5'
    expect(guidecard.path).to eq '14/0001/B4491'
  end

  it 'returns the number of image files for a heading' do
    guidecard = GuideCard.new
    guidecard.id = 2
    guidecard.heading = 'A'
    guidecard.path = '14/0001/B4491'
    guidecard.save
    expect(guidecard.image_count).to eq 151
  end
end
