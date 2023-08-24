# frozen_string_literal: true

require 'rails_helper'
require 'ruby-progressbar/outputs/null'

describe CardImageLoadingService do
  let(:cils) { described_class.new(progressbar: ProgressBar.create(output: ProgressBar::Outputs::Null)) }
  let(:sgls) do
    SubGuideLoadingService.new(csv_location: Rails.root.join('spec', 'fixtures', 'subguide_card_fixture.csv'),
                               progressbar: ProgressBar.create(output: ProgressBar::Outputs::Null))
  end
  let(:s3_response) do
    "2023-07-19 14:39:38       3422 imagecat-disk9-0091-A3037-1358.0110.tif\n2023-07-19 14:39:38       7010 imagecat-disk9-0091-A3037-1358.0111.tif\n"
  end

  before do
    allow(cils).to receive(:s3_image_list).with(anything).and_return(s3_response)
  end

  it 'can instantiate' do
    expect(cils).to be_instance_of described_class
  end

  it 'imports all card images' do
    sgls.import
    expect(CardImage.count).to eq 0
    cils.import
    expect(CardImage.count).to eq 14
    images = CardImage.where(path: '9/0091/A3037')
    expect(images.map(&:image_name)).to contain_exactly('imagecat-disk9-0091-A3037-1358.0110.tif', 'imagecat-disk9-0091-A3037-1358.0111.tif')
  end

  it 'gets a list of images from s3' do
    image_list = cils.s3_image_list('9/0091/A3037')
    expect(image_list.split("\n").count).to eq 2
  end

  it 'displays ruby-progress bar during import' do
    expect(cils.progressbar.to_h['percentage']).to eq 0
    cils.import
    expect(cils.progressbar.to_h['percentage']).to eq 100
  end
end
