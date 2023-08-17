# frozen_string_literal: true

require 'rails_helper'

describe SubGuideLoadingService do
  let(:sgls) { described_class.new(csv_location: Rails.root.join('spec', 'fixtures', 'subguide_card_fixture.csv')) }
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

  xit 'displays progress status during import' do
    expect { sgls.import }.to output("#######task completed!\n").to_stdout
  end

  it 'displays ruby-progress bar during import' do
    expect { sgls.import }.to output(/Progress: /).to_stdout_from_any_process
  end
end
