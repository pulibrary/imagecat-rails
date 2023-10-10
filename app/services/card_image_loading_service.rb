# frozen_string_literal: true

require 'ruby-progressbar'
require 'ruby-progressbar/outputs/null'

# Class for card image loading service
class CardImageLoadingService
  attr_reader :suppress_progress

  def initialize(suppress_progress: false)
    @suppress_progress = suppress_progress
  end

  def import
    import_guide_card_images
    import_sub_guide_images
  end

  # For each SubGuideCard, take its path and query s3 to get all of the image names
  # for that path. For each image file, create a CardImage object with the path and
  # image name.
  def import_sub_guide_images
    progressbar = progress_bar(SubGuideCard.count)
    SubGuideCard.all.each do |sgc|
      progressbar.increment
      image_array(sgc.path).each do |file_name|
        create_card_image(sgc, file_name)
      end
    end
  end

  def import_guide_card_images
    progressbar = progress_bar(GuideCard.count)
    GuideCard.all.each do |gc|
      progressbar.increment
      image_array(gc.path).each do |file_name|
        create_card_image(gc, file_name)
      end
    end
  end

  # returns something like
  # ["imagecat-disk9-0091-A3037-1358.0110.tif", "imagecat-disk9-0091-A3037-1358.0111.tif"]
  def image_array(path)
    s3_image_list(path).split("\n").map(&:split).map(&:last)
  end

  # returns something like
  # "2023-07-19 14:39:38       3422 imagecat-disk9-0091-A3037-1358.0110.tif\n2023-07-19 14:39:38       7010 imagecat-disk9-0091-A3037-1358.0111.tif\n"
  def s3_image_list(path)
    s3_query = "aws s3 ls s3://puliiif-production/imagecat-disk#{path.tr('/', '-')}"
    `#{s3_query}`
  end

  private

  def create_card_image(sgc, file_name)
    ci = CardImage.find_by(path: sgc.path, image_name: file_name)
    return if ci

    ci = CardImage.new
    ci.path = sgc.path
    ci.image_name = file_name
    ci.save
  end

  def progress_bar(total)
    ProgressBar.create(format: "\e[1;35m%t: |%B|\e[0m", total: total, output: progress_output)
  end

  def progress_output
    ProgressBar::Outputs::Null if suppress_progress
  end
end
