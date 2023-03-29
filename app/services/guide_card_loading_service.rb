# frozen_string_literal: true

require 'csv'
# service for loading GuideCard data
class GuideCardLoadingService
  # location of source data for GuideCards
  def csv_location
    return Rails.root.join('spec', 'fixtures', 'guide_card_fixture.csv') if Rails.env.test?

    Rails.root.join('data', 'dbo-guides', 'dbo.Guides.31756.csv')
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