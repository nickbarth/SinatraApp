#!/usr/bin/env ruby

require 'fileutils'
require 'erb'

# template vars

application = 'Application'
user = 'User'
port = 'Port'
nginx_config = 'Nginx Config'
unix_socket = 'Unix Socket'
server_ip = 'Server IP'

template_dir = './template'
target_path = './test'

all_files = Dir[ File.join(template_dir, '*.*'),
                 File.join(template_dir, '**/*.*')]
all_files.map!{|x| x.gsub(template_dir, '')}

template_files = all_files.find_all{|x| not x[/erb/].nil?}
base_files = all_files.find_all{|x| x[/erb/].nil?}

base_files.each do |base_file|
  file = File.basename(base_file)
  path = File.dirname(base_file)
  new_path = File.join(target_path, path)

  FileUtils.mkdir_p(new_path)
  FileUtils.cp File.join(template_dir, base_file),
               File.join(new_path, file)
end

template_files.each do |base_file|
  file = File.basename(base_file)
  path = File.dirname(base_file)
  new_path = File.join(target_path, path)
  new_file = File.join(new_path, file.gsub('.erb', ''))

  FileUtils.mkdir_p(new_path)
  File.open(new_file, 'w') do |source_file|
    template_file = File.join(template_dir, base_file)
    template = File.read(template_file)
    source_file << ERB.new(template).result(binding)
  end
end
