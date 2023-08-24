# frozen_string_literal: true

require 'ruby-progressbar'

# Class for card image loading service
class CardImageLoadingService
  attr_reader :progressbar

  def initialize(progressbar: nil)
    @progressbar = progressbar || ProgressBar.create(format: "\e[1;35m%t: |%B|\e[0m")
  end

  # For each SubGuideCard, take its path and query s3 to get all of the image names
  # for that path. For each image file, create a CardImage object with the path and
  # image name.

  def import
    @progressbar.total = SubGuideCard.all.count
    SubGuideCard.all.each_with_index do |sgc, index|
      progress_bar_random_color if (index % 100).zero?
      @progressbar.increment
      image_array(sgc.path).each do |file_name|
        create_card_image(sgc, file_name)
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

  def progress_bar_random_color
    @progressbar.format = "%t: |\e[#{rand(91..97)}m%B\e[0m|"
  end

  private

  def create_card_image(sgc, file_name)
    ci = CardImage.new
    ci.path = sgc.path
    ci.image_name = file_name
    ci.save
  end
end
