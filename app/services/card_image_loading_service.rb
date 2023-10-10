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
    (1..22).each { |disk| import_disk(disk) }
  end

  def import_disk(disk)
    disk_array(disk).each do |file_name|
      find_or_create_card_image(file_name)
    end
  end

  private

  # returns something like
  # ["imagecat-disk9-0091-A3037-1358.0110.tif", "imagecat-disk9-0091-A3037-1358.0111.tif"]
  def disk_array(disk)
    s3_disk_list(disk).split("\n").map(&:split).map(&:last)
  end

  # returns something like
  # "2023-07-19 14:39:38       3422 imagecat-disk9-0091-A3037-1358.0110.tif\n2023-07-19 14:39:38       7010 imagecat-disk9-0091-A3037-1358.0111.tif\n"
  def s3_disk_list(disk)
    s3_query = "aws s3 ls s3://puliiif-production/imagecat-disk#{disk}"
    `#{s3_query}`
  end

  def find_or_create_card_image(file_name)
    path = file_name.gsub('imagecat-disk', '').split('-')[0..-2].join('/')
    ci = CardImage.find_by(path:, image_name: file_name)
    return if ci

    CardImage.create(path:, image_name: file_name)
  end

  def progress_bar(total)
    ProgressBar.create(format: "\e[1;35m%t: |%B|\e[0m", total:, output: progress_output)
  end

  def progress_output
    ProgressBar::Outputs::Null if suppress_progress
  end
end
