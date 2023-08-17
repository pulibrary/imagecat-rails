# frozen_string_literal: true

require 'csv'
require 'ruby-progressbar'
# service for loading SubGuide cards data
class SubGuideLoadingService
  attr_reader :csv_location

  # @param csv_location [String] location of source data for SubGuideCards
  def initialize(csv_location: nil)
    @csv_location = csv_location || Rails.root.join('data', 'dbo-subguides', 'dbo.Subguides.17917.csv')
  end

  def import
    sub_guide_card_data = CSV.parse(File.read(csv_location), headers: true, liberal_parsing: true)
    progressbar = ProgressBar.create
    pb_increment = sub_guide_card_data.count / 100
    sub_guide_card_data.each_with_index do |entry, index|
      byebug
      2.times { progressbar.increment }
      import_sub_guide_card(entry)
    end
  end

  private

  def import_sub_guide_card(card)
    sgc = SubGuideCard.new
    sgc.id = card[0]
    sgc.heading = card[1]
    sgc.sortid = card[2]
    sgc.parentid = card[3]
    sgc.path = card[4]
    sgc.save
  end
end
