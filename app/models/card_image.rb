# frozen_string_literal: true

class CardImage < ApplicationRecord

def iiif_url
  "https://puliiif.princeton.edu/iiif/2/#{image_name.gsub(".tif","")}/full/,500/0/default.jpg"
end

end
