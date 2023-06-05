#!/usr/bin/env ruby
# frozen_string_literal: true

# This is an example of what we want our script to look like for
# transferring image files from a source location to a destination.
# ruby data/copy_images.rb /Users/faisonr/Downloads/imagecat-images-practice-1/input/disk14 s3://puliiif-staging
source = ARGV[0]
destination = ARGV[1]
puts "Copying files from #{source} to #{destination}"
files = Dir["#{source}/**/*.tiff"]
files.each do |file_name|
  puts file_name
  file_parts = file_name.split('/')
  file_parts[-1] = file_parts[-1].chop
  s3_safe_file_name = "imagecat-#{file_parts[-4..].join('-')}"
  `aws s3 cp #{file_name} #{destination}/#{s3_safe_file_name}`
end

# "/Users/faisonr/Downloads/imagecat-images-practice-1/input/disk14/**/*.tiff"
