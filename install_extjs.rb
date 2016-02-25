#!/usr/bin/env ruby

require 'fileutils'

extjs_url = "http://my.jasondenney.com/extjs-4.1.1.zip"
download_dir = '/tmp'
dest_dir ='/usr/lib'
extjs_download_path = File.join(download_dir,'extjs-4.1.1.zip')

files = Dir.glob(File.join(dest_dir, 'extjs', '*'))
if files.empty? and Dir.glob(extjs_download_path).empty?
  `wget -P #{download_dir} #{extjs_url}`
  raise "Failed downloading #{extjs_url}" if Dir.glob(extjs_download_path).empty?
end

if files.empty?
  puts `unzip #{extjs_download_path} -d #{dest_dir}/`
  FileUtils.mv(File.join(dest_dir, 'ext-4.1.1a'), File.join(dest_dir, 'extjs'))
end
raise "Failed unzipping #{extjs_download_path}" if Dir.glob(File.join(dest_dir,'extjs', '*')).empty?
