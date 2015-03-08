#!/usr/bin/env ruby
# encoding: utf-8

require 'fileutils'
require 'optparse'

Dir.chdir File.expand_path(File.dirname(__FILE__))

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: ./install.rb [options]"
  
  opts.on "--prefix=PREFIX", "Custom prefix" do |p|
    options[:prefix] = p
  end
  
  opts.on "--config", "Just install configuration (implies --overwrite)" do |c|
    options[:config] = c
    options[:overwrite] = c
  end
  
  opts.on "--overwrite", "Overwrite exsting config files" do |o|
    options[:overwrite] = o
  end
  
  opts.on "-h", "--help", "Help message" do
    puts opts
    exit
  end
  
end.parse!

prefix = options[:prefix] || '/usr/local'

unless options[:config]
  FileUtils.copy 'bin/vhost', File.join(prefix, 'bin/vhost')
  File.chmod 0755, File.join(prefix, "bin/vhost")
  puts "Installed vhost at #{File.join(prefix, 'bin')}"
  
  FileUtils.copy 'lib/vhost.rb', File.join(prefix, 'lib/vhost.rb')
  puts "Installed vhost class at #{File.join(prefix, 'lib')}"
end

FileUtils.rm_r File.join(prefix, 'etc/vhosts-conf') if options[:overwrite]

unless File.exist? File.join(prefix, 'etc/vhosts-conf')
  FileUtils.cp_r 'vhosts-conf', File.join(prefix, 'etc/vhosts-conf')
  puts "Installed vhost configuration at #{prefix}"
end