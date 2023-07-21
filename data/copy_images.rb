# frozen_string_literal: true

require 'fileutils'

# !/usr/bin/env ruby
# frozen_string_literal: true

# This is an example of what we want our script to look like for
# transferring image files from a source location to a destination.
# ruby data/copy_images.rb /var/tmp/imagecat/disk1 s3://puliiif-staging
source = ARGV[0]
destination = ARGV[1]
puts "Copying files from #{source} to #{destination}"
files = Dir[File.join(source, '**/*.tiff')]
sync_dir = File.join(source, 'for_aws_sync')
Dir.mkdir(sync_dir)
files.each do |file_name|
  puts file_name
  file_parts = file_name.split('/')
  file_parts[-1] = file_parts[-1].chop
  s3_safe_file_name = "imagecat-#{file_parts[-4..].join('-')}"
  FileUtils.cp(file_name, File.join(sync_dir, s3_safe_file_name))
end
puts 'starting aws sync'
`aws s3 sync #{sync_dir} #{destination}`
