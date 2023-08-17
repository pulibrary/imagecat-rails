# frozen_string_literal: true

require 'rails_helper'
require 'ruby-progressbar/outputs/null'

describe SubGuideLoadingService do
  let(:sgls) do
    described_class.new(csv_location: Rails.root.join('spec', 'fixtures', 'subguide_card_fixture.csv'),
                        progressbar: ProgressBar.create(output: ProgressBar::Outputs::Null))
  end
  it 'can instantiate' do
    expect(sgls).to be_instance_of described_class
  end

  it 'has a CSV file' do
    expect(sgls.csv_location).to eq Rails.root.join('spec', 'fixtures', 'subguide_card_fixture.csv')
  end

  it 'imports all data from the CSV file' do
    expect(SubGuideCard.count).to eq 0
    sgls.import
    expect(SubGuideCard.count).to eq 7
  end

  it 'displays ruby-progress bar during import' do
    expect(sgls.progressbar.to_h['percentage']).to eq 0
    sgls.import
    expect(sgls.progressbar.to_h['percentage']).to eq 100
  end
end
