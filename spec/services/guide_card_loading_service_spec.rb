# frozen_string_literal: true

require 'rails_helper'
describe GuideCardLoadingService do
  let(:fixture_file) { Rails.root.join('spec', 'fixtures', 'guide_card_fixture.csv') }
  let(:gcls) { described_class.new(csv_location: fixture_file) }
  it 'can instantiate' do
    expect(gcls).to be_instance_of described_class
  end

  it 'has a CSV file' do
    expect(gcls.csv_location).to eq fixture_file
  end

  it 'imports all data from the CSV file' do
    expect(GuideCard.count).to eq 0
    gcls.import
    expect(GuideCard.count).to eq 12
  end
end
