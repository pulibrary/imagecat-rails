# frozen_string_literal: true

require 'csv'
# service for loading SubGuide cards data
class SubGuideLoadingService
  attr_reader :csv_location

  # @param csv_location [String] location of source data for SubGuideCards
  def initialize(csv_location: nil)
    @csv_location = csv_location || Rails.root.join('data', 'dbo-subguides', 'dbo.Subguides.17917.csv')
  end

  def import(parent_guide:)
    sub_guide_card_data = CSV.parse(File.read(csv_location), headers: true)
    sub_guide_card_data.each do |card|
      import_sub_guide_card(card:, parent_guide:)
    end
  end

  private

  def import_sub_guide_card(card:, parent_guide:)
    sgc = SubGuideCard.new
    sgc.id = card[0]
    sgc.heading = card[1]
    sgc.sortid = card[2]
    sgc.parentid = card[3]
    sgc.path = card[4]
    sgc.guide_card = parent_guide
    sgc.save
  end
end
