# frozen_string_literal: true

# Class for card image loading service
class CardImageLoadingService
  # For each SubGuideCard, take its path and query s3 to get all of the image names
  # for that path. For each image file, create a CardImage object with the path and
  # image name.
  def import
    SubGuideCard.all.each do |sgc|
      ci = CardImage.new
      ci.path = sgc.path
      ci.save
    end
  end
end
