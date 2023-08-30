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

  describe '#children' do
    context 'when the guide_card has a sub_guide_card as a child' do
      it 'returns a collection that includes a child object' do
        guide_card = GuideCard.create(sortid: '50345.5')
        child_card = SubGuideCard.create(parentid: '50345.5')
        expect(guide_card.children).to contain_exactly child_card
      end
    end

    context 'when the guide_card has a regular sub_guide_card and an info sub_guide_card' do
      it 'filters out the info card' do
        guide_card = GuideCard.create(sortid: '50345.5')
        child_card = SubGuideCard.create(heading: 'Manuscripts', parentid: '50345.5', path: '14/0001/B4491')
        # Create a card that will be filtered out
        SubGuideCard.create(heading: 'Manuscripts (info)', parentid: '50345.5', path: 'info/FF')
        expect(guide_card.children).to contain_exactly child_card
      end
    end
  end
end
