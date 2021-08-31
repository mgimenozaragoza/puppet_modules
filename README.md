# Custom_nginx module for Puppet

this Module was create by Manel Gimeno <m.gimeno.zaragoza@gmail.com> 

## Table of Contents

1. [Description](#description)
1. [Setup](#setup)
    * [Requirements](#Requirements)
    * [Documentation](#Documentation)
    * [Classes](#Classes)
    * [Paramaters](#Parameters)

## Description

The module action descriptions are:

* Create a proxy to redirect requests for https://domain.com to 10.10.10.10 and redirect requests for https://domain.com/resource to 20.20.20.20.
* Create a forward proxy to log HTTP requests going from the internal network to the Internet including: request protocol, remote IP and time take to serve the request.
* (Optional) Implement a proxy health check.

The module has been tested in a Foreman 2.3.5 verions and the parameters have been configured to be used as Smart Class Parameters.

## Setup

### Requirements

* concat puppet module <https://forge.puppet.com/modules/puppetlabs/concat>
* stdlib puppet module <https://forge.puppet.com/modules/puppetlabs/stdlib>
* official nginx puppet module <https://forge.puppet.com/modules/puppet/nginx>

Both requirements are included in the repository

### Documentation

* Official nginx puppet documentation <https://forge.puppet.com/modules/puppet/nginx>

### Clases

The module custom_nginx has been devided in 3 classes

* Config - Setup is the general nginx configuration
* Reverse Proxy - Setup the Revers Proxy
* Forward Proxy - Setup the Forward Proxy

### Nginx configuration Parameters 
 * `custom_nginx_manage`	- Boolean value to enable or disable the whole custom_nginx puppet module (default: true)
 * `service_ensure`		- Set nginx service status to 'running' or 'stopped' (default: running)
 * `service_enable`		- Boolean value to enable or disable nginx service (default: true)
 * `custom_log_format_name`	- Configure the log_format name value (default: custom_log_format)
 * `custom_log_format`		- Set the custom log_format values (default: '$time_iso8601 - $remote_addr - "$request" "$status $request_time" "$http_user_agent"')

### Nginx Reverse Proxy Configuration Root Location Parameters
 * `ssl_cert`			- Path to the SSL cert (default: /etc/ssl/certs/nginx-selfsigned.crt)
 * `ssl_key`			- Path to the SSL key (default: /etc/ssl/private/nginx-selfsigned.key)
 * `reverse_proxy_ensure`	- Set if Root reverse proxy configuration should be present or absend (default: present)
 * `reverse_proxy_domain`	- Name of the Root server resource (default: domain.com)
 * `reverse_proxy_domain_proxy`	- FQDN of the Root upstream backend (default: https://backend_root)
 * `reverse_proxy_port`		- Server Proxy port (default: 443)
 * `reverse_proxy_ssl`		- Boolean value to set ssl enabled (default: true)

### Nginx Reverse Proxy Configuration Resource Location Parameters
 * `reverse_proxy_resource_ensure` - Set if Resource reverse proxy configuration should be present or absend (default: present)
 * `reverse_proxy_resource`	- Name of the Resource server resource (default: domain.com_resource)
 * `reverse_proxy_resource_ssl`	- Boolean value to set ssl enabled (default: true)
 * `reverse_proxy_resource_ssl_only`	- Boolean value to set ssl enabled (default: true)
 * `reverse_proxy_resource_location`	- Location of the Resource (default: /resource)
 * `reverse_proxy_resource_proxy`	- URL of the Resource upstream backend (default: https://backend_resource)

### Nginx Reverse Proxy Configuration Resource Location Parameters
 * `forward_proxy_ensure` - Set if Forward Proxy configuration should be present or absend (default: present)
 * `forward_proxy_domain` - Name of the Resource server resource (default: forward_proxy)
 * `forward_proxy_domain_port` - Forward Proxy port (default: 8888)
 * `forward_proxy_domain_proxy` - URL to redirect/forward connections (default: https://$http_host$request_uri)
 * `forward_proxy_domain_resolver` - Name server used to resolve names of upstream into addesses (default: ['8.8.8.8','ipv6=off'] )
