# frozen_string_literal: true

namespace :scan do
  desc 'Scan GuideCard data'
  task scan_guide_cards: :environment do
    GuideCardLoadingService.new.scan
  end
end
# this rake task scan for matching headers and generates an error if matching pairs are found
