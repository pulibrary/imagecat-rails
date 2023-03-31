# frozen_string_literal: true

require 'csv'
# service for loading SubGuide cards data
class SubGuideLoadingService
  # location of source data for SubGuides
  def csv_location
    return Rails.root.join('spec', 'fixtures', 'subguide_card_fixture.csv') if Rails.env.test?

    Rails.root.join('data', 'dbo-subguides', 'dbo.Subguides.17917.csv')
  end

  def import
    sub_guide_card_data = CSV.parse(File.read(csv_location), headers: true)
    sub_guide_card_data.each do |card|
      sgc = SubGuideCard.new
      sgc.id = card[0]
      sgc.heading = card[1]
      sgc.sortid = card[2]
      sgc.parentid = card[3]
      sgc.path = card[4]
      sgc.save
    end
  end
end
