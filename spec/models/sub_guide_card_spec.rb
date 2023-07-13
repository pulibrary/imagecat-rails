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

  describe '#parent' do # this is an instance method and not a Class method
    context 'when the sub_guide_card has a guide_card as a parent' do
      it 'returns that parent object' do
        sub_guide_card = SubGuideCard.create(parentid: '50345.5')
        guide_card = GuideCard.create(sortid: '50345.5')
        expect(sub_guide_card.parent).to eq guide_card
      end
    end

    context 'when the sub_guide_card has a sub_guide_card as a parent' do
      it 'returns that parent object' do
        sub_guide_card = SubGuideCard.create(parentid: '50345.5')
        parent_card = SubGuideCard.create(sortid: '50345.5')
        expect(sub_guide_card.parent).to eq parent_card
      end
    end
  end

  describe '#children' do
    context 'when the sub_guide_card has a sub_guide_card as a child' do
      it 'returns a collection that includes a child object' do
        sub_guide_card = SubGuideCard.create(sortid: '50345.5')
        child_card = SubGuideCard.create(parentid: '50345.5')
        expect(sub_guide_card.children).to contain_exactly child_card
      end
    end
  end

  context 'when we use a card from disk5 with path 5/0338/A5977' do
    it 'returns a URL' do
      sub_guide_image = SubGuideCard.create(path: '5/0338/A5977')
      expect(sub_guide_image.url).to eq 'https://puliiif.princeton.edu/iiif/2/imagecat-disk5-0338-A5977-0000.0073/full/,500/0/default.jpg'
    end
  end

  context 'when we use a card from disk4 with path 4/1466/B5962' do
    it 'returns a URL' do
      sub_guide_image = SubGuideCard.create(path: '4/1466/B5962')
      expect(sub_guide_image.url).to eq 'https://puliiif.princeton.edu/iiif/2/imagecat-disk4-1466-B5962-0000.0064/full/,500/0/default.jpg'
    end
  end
end
