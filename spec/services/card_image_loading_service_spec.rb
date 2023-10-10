# frozen_string_literal: true

require 'rails_helper'

describe CardImageLoadingService do
  let(:card_image_loader) { described_class.new(suppress_progress: true) }
  let(:guide_card_loader) do
    GuideCardLoadingService.new(
      csv_location: Rails.root.join('spec', 'fixtures', 'guide_card_fixture.csv'),
      progressbar: ProgressBar.create(output: ProgressBar::Outputs::Null)
    )
  end
  let(:sub_guide_card_loader) do
    SubGuideLoadingService.new(
      csv_location: Rails.root.join('spec', 'fixtures', 'subguide_card_fixture.csv'),
      progressbar: ProgressBar.create(output: ProgressBar::Outputs::Null)
    )
  end

  context 'new way' do
    let(:s3_response_disk9) do
      <<~HERE
        2023-07-19 14:39:38       3422 imagecat-disk9-0091-A3037-1358.0110.tif
        2023-07-19 14:39:38       7010 imagecat-disk9-0091-A3037-1358.0111.tif
        2023-07-19 14:39:38       7010 imagecat-disk9-0091-A3038-0000.0001.tif
        2023-07-19 14:39:38       7010 imagecat-disk9-0091-A3038-0000.0002.tif
        2023-07-19 14:39:38       7010 imagecat-disk9-0091-A3038-0000.0003.tif
        2023-07-19 14:39:38       7010 imagecat-disk9-0091-A3067-0000.0048.tif
      HERE
    end
    let(:s3_response_disk14) do
      <<~HERE
        2023-07-19 14:39:38       3422 imagecat-disk14-0001-A1007-1358.0110.tif
        2023-07-19 14:39:38       7010 imagecat-disk14-0001-A1007-1358.0111.tif
        2023-07-19 14:39:38       7010 imagecat-disk14-0002-A1008-0000.0001.tif
      HERE
    end
    before do
      allow(card_image_loader).to receive(:s3_disk_list).with(anything).and_return('')
      allow(card_image_loader).to receive(:s3_disk_list).with(9).and_return(s3_response_disk9)
      allow(card_image_loader).to receive(:s3_disk_list).with(14).and_return(s3_response_disk14)
    end

    it 'creates CardImage database entries based on the s3 listing' do
      card_image_loader.import
      expect(CardImage.find_by(image_name: 'imagecat-disk14-0002-A1008-0000.0001.tif').path).to eq '14/0002/A1008'
      expect(CardImage.count).to eq 9
      guide_card_loader.import
      sub_guide_card_loader.import
      gc = GuideCard.find_by(path: '14/0001/A1007')
      expect(CardImage.where(path: gc.path).count).to eq 2
      sgc = SubGuideCard.find_by(path: '9/0091/A3038')
      expect(CardImage.where(path: sgc.path).count).to eq 3
      # If you reimport, it doesn't create duplicate rows
      card_image_loader.import
      expect(CardImage.count).to eq 9
    end
  end
end
