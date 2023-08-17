# frozen_string_literal: true

require 'csv'
require 'ruby-progressbar'
# service for loading SubGuide cards data
class SubGuideLoadingService
  attr_reader :csv_location, :progressbar

  # @param csv_location [String] location of source data for SubGuideCards
  def initialize(csv_location: nil, progressbar: nil)
    @csv_location = csv_location || Rails.root.join('data', 'dbo-subguides', 'dbo.Subguides.17917.csv')
    @progressbar = progressbar || ProgressBar.create(format: "\e[1;35m%t: |%B|\e[0m")
  end

  def import
    sub_guide_card_data = CSV.parse(File.read(csv_location), headers: true, liberal_parsing: true)
    @progressbar.total = sub_guide_card_data.count
    sub_guide_card_data.each_with_index do |entry, index|
      progress_bar_random_color if (index % 100).zero?
      @progressbar.increment
      import_sub_guide_card(entry)
    end
  end

  def progress_bar_random_color
    @progressbar.format = "%t: |\e[#{rand(91..97)}m%B\e[0m|"
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
