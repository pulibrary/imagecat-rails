# frozen_string_literal: true

require 'rails_helper'
# rubocop:disable Metrics/BlockLength
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
    expect(GuideCard.count).to eq 11
  end

  it 'does not log matching data' do
    allow(Rails.logger).to receive(:info)
    gcls.scan
    expect(Rails.logger).not_to have_received(:info)
  end

  context 'with a fixture file with non-matching data' do
    let(:fixture_file) { Rails.root.join('spec', 'fixtures', 'guide_card_fixture_non_matching_data.csv') }
    it 'logs non-matching data' do
      allow(Rails.logger).to receive(:info)
      gcls.scan
      expect(Rails.logger).to have_received(:info).with('***** does not match house in record 1')
      expect(Rails.logger).to have_received(:info).with('14/0001/A1002 does not match 14/0001/A1234 in record 3')
    end
  end

  context 'with a CSV that has duplicate headings' do
    before do
      File.delete(new_csv) if File.exist?(new_csv)
    end
    let(:fixture_file) { Rails.root.join('spec', 'fixtures', 'guide_card_fixture.csv') }
    let(:new_csv) { Rails.root.join('spec', 'fixtures', 'deduplicated_guide_card_fixture.csv') }
    it 'writes a new file without duplicate headings' do
      expect(File.exist?(new_csv)).to eq false
      guide_card_data = CSV.parse(File.read(fixture_file), headers: true)
      expect(guide_card_data.headers).to contain_exactly('ID', 'heading', 'sortid', 'path', 'ID', 'heading', 'sortid',
                                                         'path')
      expect(guide_card_data.count).to eq 11
      gcls.deduplicate_csv_headings(new_csv)
      deduplicate_guide_card_data = CSV.parse(File.read(new_csv), headers: true)
      expect(deduplicate_guide_card_data.headers).to contain_exactly('ID', 'heading', 'sortid', 'path')
      expect(deduplicate_guide_card_data.count).to eq 11
    end
  end
end
# rubocop:enable Metrics/BlockLength
