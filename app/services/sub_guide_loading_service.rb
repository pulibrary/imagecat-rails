# frozen_string_literal: true

require 'csv'
# service for loading SubGuide cards data
class SubGuideLoadingService
  # location of source data for SubGuides
  def csv_location
    return Rails.root.join('spec', 'fixtures', 'subguide_card_fixture.csv') if Rails.env.test?

    Rails.root.join('data', 'dbo-subguides', 'dbo.Subguides.17917.csv')
  end
end
