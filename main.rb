require 'fileutils'
require 'dotenv'
Dotenv.load

src_path = ENV['SRC_PATH']
dest_path = ENV['DEST_PATH']

puts src_path, dest_path

files = Dir.glob("#{src_path}/**/*.JPG")

files.each do |filename_in_fullpath|
  puts filename_in_fullpath

  filename = filename_in_fullpath.split('/').last

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

  puts "copying... #{dest_filename}"
  FileUtils.copy(filename_in_fullpath, File.join(dest_path, dest_filename))

  break
end
