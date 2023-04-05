# frozen_string_literal: true

require 'csv'
# service for loading GuideCard data
class GuideCardLoadingService
  attr_reader :csv_location

  # @param csv_location [String] location of source data for GuideCards
  def initialize(csv_location: nil)
    @csv_location = csv_location || Rails.root.join('data', 'dbo-guides', 'dbo.Guides.31756.csv')
  end

  def import
    guide_card_data = CSV.parse(File.read(csv_location), headers: true)
    guide_card_data.each do |card|
      gc = GuideCard.new
      gc.id = card[0]
      gc.heading = card[1]
      gc.sortid = card[2]
      gc.path = card[3]
      gc.save
    end
  end
end
