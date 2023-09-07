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

  context 'knows what page of the index it should be on' do
    it 'id 2 is on the first page' do
      guide_card2 = GuideCard.create(id: 2)
      expect(guide_card2.index_page).to eq 1
    end
    it 'id 11 is on the second page' do
      guide_card11 = GuideCard.create(id: 11)
      expect(guide_card11.index_page).to eq 2
    end
    it 'id 30 is on the third page' do
      guide_card30 = GuideCard.create(id: 30)
      expect(guide_card30.index_page).to eq 3
    end
    it 'id 19 is on the second page' do
      guide_card19 = GuideCard.create(id: 19)
      expect(guide_card19.index_page).to eq 2
    end
  end
end
