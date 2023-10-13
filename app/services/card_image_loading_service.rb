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
      semaphore = Async::Semaphore.new(22, parent: barrier)
      # Fetch all the files first - there's a lot, but not so many that it can't
      # sit in memory, and async 22 makes this fast enough.
      all_files = (1..22).map do |disk|
        semaphore.async do
          disk_array(disk)
        end
      end.flat_map(&:wait)
      progress_bar.total = all_files.count
      progress_bar.progress = 0
      import_files(all_files)
    ensure
      barrier.stop
    end
  end

  def import_files(all_files)
    # insert_all in batches of 1000
    all_files.each_slice(1000) do |slice|
      import_slice(slice)
    end
  end

  def import_slice(slice)
    # Create an array of hashes that represent what we want to insert.
    insert_slice = slice.map do |file_name|
      path = file_name.gsub('imagecat-disk', '').split('-')[0..-2].join('/')
      { path: path, image_name: file_name }
    end
    result = CardImage.insert_all(insert_slice)
    logger.info("Created #{result.count} rows")
    progress_bar.progress += slice.count
  end

  private

  # returns something like
  # ["imagecat-disk9-0091-A3037-1358.0110.tif", "imagecat-disk9-0091-A3037-1358.0111.tif"]
  def disk_array(disk)
    logger.info("Fetching disk #{disk} file list")
    s3_disk_list(disk).split("\n").map(&:split).map(&:last)
  end

  # returns something like
  # "2023-07-19 14:39:38       3422 imagecat-disk9-0091-A3037-1358.0110.tif\n2023-07-19 14:39:38       7010 imagecat-disk9-0091-A3037-1358.0111.tif\n"
  # :nocov:
  def s3_disk_list(disk)
    `aws s3 ls s3://puliiif-production/imagecat-disk#{disk}-`
  end
  # :nocov:

  def progress_bar
    @progress_bar ||= ProgressBar.create(format: '%a %e %P% Loading: %c from %C', output: progress_output, total: 0, title: 'Image import')
  end

  def progress_output
    ProgressBar::Outputs::Null if suppress_progress
  end
end
