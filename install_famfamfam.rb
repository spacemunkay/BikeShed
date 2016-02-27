#!/usr/bin/env ruby

require 'fileutils'

fam_url = "http://www.famfamfam.com/lab/icons/silk/famfamfam_silk_icons_v013.zip"
download_dir = '/tmp'
dest_dir = "/usr/lib/famfamfam"
fam_download_path = File.join(download_dir,'famfamfam_silk_icons_v013.zip')

files = Dir.glob(File.join(dest_dir, '*'))
if files.empty? and Dir.glob(fam_download_path).empty?
  `wget -P #{download_dir} #{fam_url}`
  raise "Failed downloading #{fam_url}" if Dir.glob(fam_download_path).empty?
end

if files.empty?
  puts `unzip #{fam_download_path} -d #{dest_dir}/`
end
raise "Failed unzipping #{fam_download_path}" if Dir.glob(File.join(dest_dir, '*')).empty?
