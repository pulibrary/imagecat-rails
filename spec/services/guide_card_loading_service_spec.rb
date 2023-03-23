# frozen_string_literal: true

require 'rails_helper'

describe GuideCardLoadingService do
  let(:gcls) { described_class.new }
  it 'can instantiate' do
    expect(gcls).to be_instance_of described_class
  end

  it 'has a CSV file' do
    expect(gcls.csv_location).to eq Rails.root.join('data', 'dbo-guides', 'dbo.Guides.31756.csv')
  end

  it 'imports all data from the CSV file' do
    expect(GuideCard.count).to eq 0
    gcls.import
    expect(GuideCard.count).to eq 31_756
  end
end
