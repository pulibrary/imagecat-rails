# frozen_string_literal: true

require 'rails_helper'

describe CardImageLoadingService do
  let(:cils) { described_class.new }
  it 'can instantiate' do
    expect(cils).to be_instance_of described_class
  end

  it 'imports all card images' do
    expect(CardImage.count).to eq 0
    cils.import
    expect(CardImage.count).to eq 1
  end
end
