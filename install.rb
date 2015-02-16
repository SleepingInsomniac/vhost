#!/usr/bin/env ruby

require 'fileutils'

Dir.chdir File.expand_path(File.dirname(__FILE__))
FileUtils.copy 'vhost', '/usr/local/bin/vhost'
FileUtils.copy 'vhosts-conf', '/usr/local/etc/vhosts-conf'

File.chmod 0755, "/usr/local/bin/vhosts"