Gem::Specification.new do |s|
  s.name          = 'vhost'
  s.version       = '1.1.2'
  s.licenses      = ['MIT']
  s.summary       = "Take control of your virtual hosts."
  s.description   = "Create, enabled, disable, and delete virtual hosts with ease."
  s.authors       = ["Alex Clink"]
  s.email         = 'code@alexclink.com'
  s.homepage      = 'https://github.com/sleepinginsomniac/vhost'
  s.files         = [
    "lib/vhost.rb",
    "bin/vhost",
    'vhosts-conf/vhosts.yml',
    'vhosts-conf/templates/apache.conf.erb',
    'vhosts-conf/templates/nginx.conf.erb'
  ]
  s.executables   = ["vhost"]
  s.require_paths = ["vhost-conf"]
  
end