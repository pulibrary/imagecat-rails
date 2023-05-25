# frozen_string_literal: true

namespace :deduplicate do
  desc 'Deduplicate GuideCard data'
  task deduplicate_guide_card_data: :environment do
    deduplicated_guide_cards = Rails.root.join('data', 'dbo-guides', 'deduplicated_guide_cards.csv')
    GuideCardLoadingService.new.deduplicate_csv_headings(deduplicated_guide_cards)
  end
end
# this rake task scan for matching headers and generates an error if matching pairs are found
