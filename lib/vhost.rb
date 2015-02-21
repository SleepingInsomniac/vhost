# ======================
# = Vhost - Alex Clink =
# ======================
# http://alexclink.com

class Vhost
  
  require 'fileutils'
  require 'erubis'
  require 'yaml'
  
  VERSION = "1.1.1"
  CONF_NAME = "vhosts.yml"
  CONFIG_PATHS = [
    'vhosts-conf',
    '../etc/vhosts-conf',
    '/usr/local/etc/vhosts-conf',
    '/etc/vhosts-conf'
  ]
    
  def self.load_conf(paths = CONFIG_PATHS)
    Dir.chdir File.expand_path(File.dirname(__FILE__))
    @@config_path = CONFIG_PATHS.select { |path| File.exist? path }.first
    raise "Can't find configuration!\nSearch locations:\n#{CONFIG_PATHS.join("\n")}" if @@config_path.nil?
    @@config_file = File.join(@@config_path, 'vhosts.yml')
    
    conf = YAML.load_file @@config_file
    conf['server_conf']      ||= '/usr/local/etc/nginx'
    conf['sites_folder']     ||= '/var/www'
    conf['default_template'] ||= 'nginx.conf.erb'
    conf['editor']           ||= 'open'
    
    conf
  end
  
  @@conf = self.load_conf
  @@available_path = File.join(@@conf['server_conf'], 'sites-available')
  @@enabled_path   = File.join(@@conf['server_conf'], 'sites-enabled')
  
  def self.conf
    @@conf
  end
  
  def self.conf_file
    @@config_file
  end
  
  def self.save_conf
    File.open @@config_file, "w" do |file|
      file.write @@conf.to_yaml
    end
  end
  
  def self.available
    Dir[File.join(@@available_path, '*')]
  end
  
  def self.enabled
    Dir[File.join(@@enabled_path, '*')]
  end
  
  def self.all
    self.available.map do |path|
      Vhost.find File.basename(path)
    end
  end
  
  def self.find(name)
    name = Dir[File.join(@@available_path, "#{name}*")].first
    return false if name.nil?
    
    name = File.basename(name)
    Vhost.new(name)
  end
  
  def self.create(name)
    return false if Vhost.find(name)
      
    File.open File.join(@@available_path, "#{name}.conf"), "w" do |f|
      template = Erubis::Eruby.new File.read(File.join(@@config_path, 'templates', @@conf['default_template']))    
      f.write template.result(vhost: name, conf: @@conf)
    end
    
    Vhost.find(name)
  end
  
  # ====================
  # = Instance Methods =
  # ====================
  
  def initialize(name)
    @name = name
    @paths = {
      enabled: File.join(@@conf['server_conf'], 'sites-enabled', @name),
      available: File.join(@@conf['server_conf'], 'sites-available', @name),
      folder: File.join(@@conf['sites_folder'], basename)
    }
  end
  
  attr_reader :paths
  attr_reader :name
  
  def basename
    File.basename(@name, ".conf")
  end
  
  def enabled?
    File.exist? @paths[:enabled]
  end
  
  def enable
    return false if enabled?
    File.symlink @paths[:available], @paths[:enabled]
  end
  
  def disable
    return false unless enabled?
    File.unlink @paths[:enabled]
  end
  
  def delete!
    File.unlink @paths[:enabled] if enabled?
    File.unlink @paths[:available]
  end
  
  def to_s
    basename
  end
  
end