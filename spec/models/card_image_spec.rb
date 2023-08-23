# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CardImage, type: :model do
  it 'can be instantiated' do
    ci = CardImage.new
    ci.path = '5/0338/A5977'
    ci.image_name = 'imagecat-disk5-0338-A5977-0000.0001.tif'
    ci.save
  end
  it 'has a iiif url' do
    ci = CardImage.new
    ci.path = '5/0338/A5977'
    ci.image_name = 'imagecat-disk1-0675-B1764-0000.0219.tif'
    ci.save
    expect(ci.iiif_url).to eq 'https://puliiif.princeton.edu/iiif/2/imagecat-disk1-0675-B1764-0000.0219/full/,500/0/default.jpg'
  end
end
