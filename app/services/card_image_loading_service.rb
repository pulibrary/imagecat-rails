# frozen_string_literal: true

# Class for card image loading service
class CardImageLoadingService
  # For each SubGuideCard, take its path and query s3 to get all of the image names
  # for that path. For each image file, create a CardImage object with the path and
  # image name.
  def import
    SubGuideCard.all.each do |sgc|
      # Get an array of all file names on s3 that start that sgc.path
      # For each file name
      image_array(sgc.path).each do |file_name|
        ci = CardImage.new
        ci.path = sgc.path
        ci.image_name = file_name
        ci.save
        print '#'
        $stdout.flush
      end
    end
    puts 'task completed!'
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
end
