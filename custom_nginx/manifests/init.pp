# @summary custom NGINX module
#
# ######################
# Objective
# ######################
#  1 - Create a proxy to redirect requests for https://domain.com to 10.10.10.10 and redirect requests for https://domain.com/resource to 20.20.20.20.
#  2 - Create a forward proxy to log HTTP requests going from the internal network to the Internet including: request protocol, remote IP and time take to serve the request.
#  3 - (Optional) Implement a proxy health check.
#
class custom_nginx (
  Boolean $custom_nginx_manage     = $custom_nginx::params::custom_nginx_manage,
  $service_ensure                  = $custom_nginx::params::service_ensure,
  $service_enable                  = $custom_nginx::params::service_enable,
  Boolean $service_manage          = $custom_nginx::params::service_manage,
  $custom_log_format_name          = $custom_nginx::params::custom_log_format_name,
  $custom_log_format               = $custom_nginx::params::custom_log_format,
  $ssl_cert                        = $custom_nginx::params::ssl_cert,
  $ssl_key                         = $custom_nginx::params::ssl_key,
  $reverse_proxy_ensure            = $custom_nginx::params::reverse_proxy_ensure,
  $reverse_proxy_domain_name       = $custom_nginx::params::reverse_proxy_domain_name,
  $reverse_proxy_domain_proxy      = $custom_nginx::params::reverse_proxy_domain_proxy,
  $reverse_proxy_port              = $custom_nginx::params::reverse_proxy_port,
  $reverse_proxy_ssl               = $custom_nginx::params::reverse_proxy_ssl,
  $reverse_proxy_resource_ensure   = $custom_nginx::params::reverse_proxy_resource_ensure,
  $reverse_proxy_resource_name     = $custom_nginx::params::reverse_proxy_resource_name,
  $reverse_proxy_resource_ssl      = $custom_nginx::params::reverse_proxy_resource_ssl,
  $reverse_proxy_resource_ssl_only = $custom_nginx::params::reverse_proxy_resource_ssl_only,
  $reverse_proxy_resource_location = $custom_nginx::params::reverse_proxy_resource_location,
  $reverse_proxy_resource_proxy    = $custom_nginx::params::reverse_proxy_resource_proxy,
  $forward_proxy_ensure            = $custom_nginx::params::forward_proxy_ensure,
  $forward_proxy_domain_name       = $custom_nginx::params::forward_proxy_domain_name,
  $forward_proxy_domain_port       = $custom_nginx::params::forward_proxy_domain_port,
  $forward_proxy_domain_proxy      = $custom_nginx::params::forward_proxy_domain_proxy,
  $forward_proxy_domain_resolver   = $custom_nginx::params::forward_proxy_domain_resolver,
) inherits custom_nginx::params {
    include stdlib
    validate_bool($custom_nginx_manage)
    validate_bool($service_manage)

    if ($custom_nginx_manage) {
      if ($::osfamily == "RedHat" and $::operatingsystemmajrelease > '5') {

        contain custom_nginx::config
        contain custom_nginx::forward_proxy
        contain custom_nginx::reverse_proxy

        Class['custom_nginx::config'] -> Class['custom_nginx::forward_proxy']
        Class['custom_nginx::config'] -> Class['custom_nginx::reverse_proxy']
      }
    }
}
