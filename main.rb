require 'fileutils'
require 'dotenv'
Dotenv.load

SRC_PATH = ENV['SRC_PATH']
DEST_PATH = ENV['DEST_PATH']
puts SRC_PATH, DEST_PATH


def build_dest_fullpath(dest_path:, filename:)
  dest_filename = filename
  if File.exist?(File.join(dest_path, dest_filename))
    chanks = filename.split('.')
    i = 0
    loop do
      dest_filename = "#{chanks[0..-2].join('.')}_#{i}.#{chanks[-1]}"
      break unless File.exist?(File.join(dest_path, dest_filename))
      i += 1
    end
  end
  File.join(dest_path, dest_filename)
end


files = Dir.glob("#{SRC_PATH}/**/*.JPG")

files.each do |filename_in_fullpath|
  filename = filename_in_fullpath.split('/').last
  dest_fullpath = build_dest_fullpath(dest_path: DEST_PATH, filename: filename)

  puts "copying... #{dest_fullpath}"
  FileUtils.copy(filename_in_fullpath, dest_fullpath)

  break
end
