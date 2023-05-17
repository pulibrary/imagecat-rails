# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SubGuideCard, type: :model do
  it 'has the SubGuideCard fields' do
    subguidecard = SubGuideCard.new
    subguidecard.id = 2
    subguidecard.heading = 'Afdeling natuurkunde'
    subguidecard.sortid = '50350.5'
    subguidecard.parentid = '50345.5'
    subguidecard.path = '9/0091/A3067'
    subguidecard.guide_card = GuideCard.create
    subguidecard.save
    expect(subguidecard.id).to eq 2
    expect(subguidecard.heading).to eq 'Afdeling natuurkunde'
    expect(subguidecard.sortid).to eq '50350.5'
    expect(subguidecard.parentid).to eq '50345.5'
    expect(subguidecard.path).to eq '9/0091/A3067'
    expect(subguidecard.guide_card.class).to eq GuideCard 
  end
end
