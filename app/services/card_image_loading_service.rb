# frozen_string_literal: true

require 'ruby-progressbar'
require 'ruby-progressbar/outputs/null'
require 'async/semaphore'
require 'async/barrier'

# Class for card image loading service
class CardImageLoadingService
  attr_reader :logger, :suppress_progress

  def initialize(logger: nil, suppress_progress: false)
    @logger = logger || Logger.new($stdout)
    @suppress_progress = suppress_progress
  end

  def import
    barrier = Async::Barrier.new
    Sync do
      semaphore = Async::Semaphore.new(10, parent: barrier)

      (1..22).map do |disk|
        semaphore.async do
          import_disk(disk)
        end
      end.map(&:wait)
    ensure
      barrier.stop
    end
  end

  def import_disk(disk)
    logger.info("Fetching disk #{disk} file list")
    filenames = disk_array(disk)
    progress_bar.total += filenames.count
    Sync do |task|
      filenames.map do |file_name|
        task.async do
          progress_bar.increment
          find_or_create_card_image(file_name)
        end
      end.map(&:wait)
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
    `aws s3 ls s3://puliiif-production/imagecat-disk#{disk}-`
  end

  def find_or_create_card_image(file_name)
    path = file_name.gsub('imagecat-disk', '').split('-')[0..-2].join('/')
    ci = CardImage.find_by(path: path, image_name: file_name)
    return if ci

    CardImage.create(path: path, image_name: file_name)
  end

  def progress_bar
    @progress_bar ||= ProgressBar.create(format: '%a %e %P% Loading: %c from %C', output: progress_output, total: 0, title: 'Image import')
  end

  def progress_bar_old(total)
    ProgressBar.create(format: '%a %e %P% Loading: %c from %C', total: total, output: progress_output)
  end

  def progress_output
    ProgressBar::Outputs::Null if suppress_progress
  end
end
