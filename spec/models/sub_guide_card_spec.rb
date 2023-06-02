# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SubGuideCard, type: :model do
  it 'has the SubGuideCard fields' do
    sub_guide_card = SubGuideCard.new
    sub_guide_card.id = 2
    sub_guide_card.heading = 'Afdeling natuurkunde'
    sub_guide_card.sortid = '50350.5'
    sub_guide_card.parentid = '50345.5'
    sub_guide_card.path = '9/0091/A3067'
    sub_guide_card.save
    expect(sub_guide_card.id).to eq 2
    expect(sub_guide_card.heading).to eq 'Afdeling natuurkunde'
    expect(sub_guide_card.sortid).to eq '50350.5'
    expect(sub_guide_card.parentid).to eq '50345.5'
    expect(sub_guide_card.path).to eq '9/0091/A3067'
  end
end
