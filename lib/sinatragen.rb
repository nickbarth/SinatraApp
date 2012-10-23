require 'fileutils'
require 'ostruct'
require 'erb'
require 'sinatragen/version'

class SinatraGen
  attr_accessor :template_dir
  attr_accessor :target_path
  attr_accessor :template_data
  attr_writer :source_files

  def initialize(template_dir, target_path, template_data)
    @template_dir = template_dir
    @template_data = template_data
    @target_path = target_path
  end

  def run
    source_files.each do |source_file|
      transfer_file source_file
    end
  end

  def source_files
    @source_files ||= ->{
      Dir[ File.join(template_dir, '*.*'),
           File.join(template_dir, '**/*.*') ].
      map!{|file| file.gsub(@template_dir, '')}
    }[]
  end

  def template_file?(filename)
    not filename[/erb/].nil?
  end

  def file_data(base_file)
    file = File.basename(base_file)
    path = File.dirname(base_file)
    new_path = File.join(@target_path, path)
    new_file = File.join(new_path, file.gsub('.erb', ''))
    [file, path, new_path, new_file]
  end

  def copy_file(source, dest)
    FileUtils.cp(File.join(@template_dir, source), dest)
  end

  def template_file(source, dest)
    File.open(dest, 'w') do |source_file|
      template_file = File.join(@template_dir, source)
      template = File.read(template_file)
      source_file << ERB.new(template).
        result(@template_data.instance_eval { binding })
    end
  end

  def transfer_file(base_file)
    file, path, new_path, new_file = file_data(base_file)
    FileUtils.mkdir_p(new_path)
    if template_file?(base_file)
      template_file(base_file, new_file)
    else
      copy_file(base_file, new_file)
    end
  end
end
