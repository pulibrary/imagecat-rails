# frozen_string_literal: true

namespace :import do
  desc 'Import GuideCard data'
  task import_guide_cards: :environment do
    GuideCardLoadingService.new.import
  end

  desc 'Import SubGuideCard data'
  task import_sub_guide_cards: :environment do
    SubGuideLoadingService.new.import
  end
end
