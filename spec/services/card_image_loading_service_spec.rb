# frozen_string_literal: true

require 'rails_helper'

describe CardImageLoadingService do
  let(:cils) { described_class.new }
  let(:sgls) do
    SubGuideLoadingService.new(csv_location: Rails.root.join('spec', 'fixtures', 'subguide_card_fixture.csv'))
  end
  let(:s3_response) do
    "2023-07-19 14:39:38       3422 imagecat-disk9-0091-A3037-1358.0110.tif\n2023-07-19 14:39:38       7010 imagecat-disk9-0091-A3037-1358.0111.tif\n"
  end
  it 'can instantiate' do
    expect(cils).to be_instance_of described_class
  end

  it 'imports all card images' do
    allow(cils).to receive(:s3_image_list).and_return(s3_response)
    sgls.import
    expect(CardImage.count).to eq 0
    cils.import
    expect(CardImage.count).to eq 12
    images = CardImage.where(path: '9/0091/A3037')
    expect(images.map(&:image_name)).to contain_exactly('imagecat-disk9-0091-A3037-1358.0110.tif', 'imagecat-disk9-0091-A3037-1358.0111.tif')
  end
end
