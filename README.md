# vhost
A simple way to manage virtual hosts in nginx or apache.  
Create, delete, enable, and disable vitual hosts.

Configurations are based on erb templates

##Install:
vhost requires ruby to be installed
###Hombrew:

    $ brew tap sleepinginsomniac/formulae
    $ brew install vhost
    
###*nix:

	cd `path/to/vhost`
    ./create_config
    mv vhost /usr/local/bin/vhost
    chmod u+x /usr/local/bin/vhost

##Examples:

	# Creates a new file based on the template in sites-available
	vhost example.com -c
	# Create enable and restart the server in one swift motion
	vhost example.com -cer
	# Disable a virtual host
	vhost example.com -d  
	
for more options: `vhost -h`

##Configuration
the default configuration is a simple yaml file:

####Nginx:

	---
	server_conf: '/usr/local/etc/nginx'
	sites_folder: '/var/www'
	default_template: 'nginx.conf.erb'
	restart_cmd: 'sudo nginx -s reload'

####Apache:

	---
	server_conf: '/usr/local/etc/apache2/2.4'
	sites_folder: '/var/www'
	default_template: 'apache.conf.erb'
	restart_cmd: 'sudo apachectl graceful'

