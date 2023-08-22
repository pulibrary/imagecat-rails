# frozen_string_literal: true

require 'csv'
require 'ruby-progressbar'
# service for loading GuideCard data
class GuideCardLoadingService
  attr_reader :csv_location, :progressbar

  # @param csv_location [String] location of source data for GuideCards
  def initialize(csv_location: nil, progressbar: nil)
    @csv_location = csv_location || Rails.root.join('data', 'dbo-guides', 'dbo.Guides.31756.csv')
    @progressbar = progressbar || ProgressBar.create(format: "\e[1;35m%t: |%B|\e[0m")
  end

  def import
    guide_card_data = CSV.parse(File.read(csv_location), headers: true)
    @progressbar.total = guide_card_data.count
    guide_card_data.each_with_index do |entry, index|
      progress_bar_random_color if (index % 100).zero?
      @progressbar.increment
      import_guide_card(entry)
    end
  end

  def progress_bar_random_color
    @progressbar.format = "%t: |\e[#{rand(91..97)}m%B\e[0m|"
  end

  private

  def import_guide_card(guide_card)
    gc = GuideCard.new
    gc.id = guide_card[0]
    gc.heading = guide_card[1]
    gc.sortid = guide_card[2]
    gc.path = guide_card[3]
    gc.save
  end
end
