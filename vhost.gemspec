Gem::Specification.new do |s|
  s.name          = 'vhost'
  s.version       = '1.1.3'
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
  s.add_dependency 'colorize', '~> 0.7'
  s.add_dependency 'erubis', '~> 2.7'
end