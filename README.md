# vhost
A simple way to manage virtual hosts in nginx, apache, or other server software.  
Create, delete, enable, and disable vitual hosts.

Configurations are based on erb templates

##Install:
vhost requires ruby to be installed
###Hombrew:

	brew tap sleepinginsomniac/formulae
	brew install vhost
	
###*nix:

	wget https://github.com/SleepingInsomniac/vhost/archive/1.0.2.tar.gz
	tar -zxvf 1.0.2.tar.gz
	cd vhost-1.0.2
	sudo ./install.rb

##Examples:

	# Creates a new file based on the template in sites-available
	vhost example.com -c

	# Create enable and restart the server in one swift motion
	vhost example.com -cer

	# Disable a virtual host
	vhost example.com -d

	# Modify a virtual host
	vhost example.com -m
	
for more options: `vhost -h`

##Configuration
The default configuration is a simple yaml file. vhost could conceivably be used with any server that supports virtual hosts.

The structure vhost expects is that `server_conf` points to your server configuration directory that contains `sites-available` and `sites-enabled`. If this isn't how your sever is set up, you may need to add something like `include /usr/local/etc/nginx/sites-enabled/*;` to your server config file, and create those two directories.


##Config examples:
####Nginx:

	---
	server_conf: '/usr/local/etc/nginx'
	sites_folder: '/var/www'
	default_template: 'nginx.conf.erb'
	restart_cmd: 'sudo nginx -s reload'
	editor: emacs

####Apache:

	---
	server_conf: '/usr/local/etc/apache2/2.4'
	sites_folder: '/var/www'
	default_template: 'apache.conf.erb'
	restart_cmd: 'sudo apachectl graceful'
	editor: emacs

##Templates

vhost comes with templates for two popular webservers: nginx and apache. To edit a template use: `vhost -mt 'template_name'`. To create a virtual host with a template other than the default use: `vhost example.com -c -t 'template_name'`

	<% site_root = File.join(conf['sites_folder'], vhost, "public") %>
	<% site_name = vhost %>
	<% error_log = File.join(conf['sites_folder'], vhost, "log", "nginx-error.log") %>
	<% access_log = File.join(conf['sites_folder'], vhost, "log", "nginx-access.log") %>
	
	server {
		listen 80;
		
		root <%= site_root %>;
		server_name <%= site_name %>;
		error_log <%= error_log %>;
		access_log <%= access_log %>;
	  
		index index.php index.html;
		
		location / {
			# include /usr/local/etc/nginx/conf.d/php-fpm; # enable php
			# passenger_enabled on # enabled passenger for rack based apps
			# autoindex on; # just for development
		}
		
	}