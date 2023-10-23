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

  desc 'Import CardImage data'
  task import_card_images: :environment do
    CardImageLoadingService.new.import
  end

  desc 'Import InfoCard data'
  task import_info_cards: :environment do
    InfoCardLoadingService.new.import
  end
end
