# frozen_string_literal: true

# index page pagenation = 10 records per page
class GuideCard < ApplicationRecord
  paginates_per 10
  def image_count
    image_dir="#{images_location.to_s}/disk#{path}"
    Dir["#{image_dir}/*.tiff"].count
  end
  def images_location
    ENV['IMAGECAT_IMAGES'] || Rails.root.join('spec/fixtures/images')
  end
end
