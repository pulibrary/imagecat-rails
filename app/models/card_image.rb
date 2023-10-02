# frozen_string_literal: true

# Class for CardImage data models
class CardImage < ApplicationRecord
  paginates_per 10
  def iiif_url
    "https://puliiif.princeton.edu/iiif/2/#{image_name.gsub('.tif', '')}/full/,500/0/default.jpg"
  end
end
