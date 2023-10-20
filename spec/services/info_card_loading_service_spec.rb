# frozen_string_literal: true

require 'rails_helper'

describe InfoCardLoadingService do
  let(:icls) { described_class.new }
  it 'can instantiate' do
    expect(icls).to be_instance_of described_class
  end

  # rubocop:disable Layout/LineLength
  it 'creates an object for each file in data/info_files' do
    expect(InfoCard.count).to eq 0
    icls.import
    expect(InfoCard.count).to eq 45
    expect(InfoCard.first.path).to eq 'info/A'
    expect(InfoCard.first.html).to start_with "Entries under this author are grouped as follows:\n<ol>"
    expect(InfoCard.find_by(path: 'info/AA').html).to eq 'This file contains all entries beginning UNITED STATES--HISTORY, e.g., UNITED STATES--HISTORY--CIVIL WAR, 1861-1865--SOURCES, or UNITED STATES--HISTORY, MILITARY.'
  end
  # rubocop:enable Layout/LineLength
end
