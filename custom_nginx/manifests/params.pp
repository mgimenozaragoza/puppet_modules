# Class to set default params
class custom_nginx::params {
  
  # Manage Nginx service using nginx class variable
  $custom_nginx_manage = true
  $service_ensure      = 'running'
  $service_enable      = true
  $service_manage      = true
 
  # Server configuration nginx.conf
  $custom_log_format_name = 'custom_log_format'
  $custom_log_format      = '$time_iso8601 - $remote_addr - "$request" "$status $request_time" "$http_user_agent"'

  # Control if resources are managed
  $reverse_proxy_manage          = true
  $reverse_proxy_resource_manage = true
  $forward_proxy_manage          = true
 
  # Set SSL certs
  $ssl_cert = '/etc/ssl/certs/nginx-selfsigned.crt'
  $ssl_key  = '/etc/ssl/private/nginx-selfsigned.key'
  
  # Reverse Proxy Params
  $reverse_proxy_ensure          = present
  $reverse_proxy_domain_name  = 'domain.com'
  $reverse_proxy_domain_proxy = 'https://backend_root'
  $reverse_proxy_port         = 443
  $reverse_proxy_ssl          = true

  # Reverse Proxy Resource params
  $reverse_proxy_resource_ensure = present
  $reverse_proxy_resource_name     = 'domain.com_resource'
  $reverse_proxy_resource_ssl      = true
  $reverse_proxy_resource_ssl_only = true
  $reverse_proxy_resource_location = '/resource'
  $reverse_proxy_resource_proxy    = 'https://backend_resource'

  # Forward Proxy Params
  $forward_proxy_domain_ensure = present
  $forward_proxy_domain_name     = 'forward_proxy'
  $forward_proxy_domain_port     = 8888
  $forward_proxy_domain_proxy    = 'https://$http_host$request_uri'
  $forward_proxy_domain_resolver = ['8.8.8.8','ipv6=off']
}
