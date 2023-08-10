require 'rails_helper'

RSpec.describe CardImage, type: :model do
  it 'can be instantiated' do
    ci = CardImage.new 
    ci.path = "5/0338/A5977"
    ci.image_name = "imagecat-disk5-0338-A5977-0000.0001.tif"
    ci.save 
  end
end
