# Class to configure custom_nginx forward_proxy
class custom_nginx::forward_proxy inherits custom_nginx {
  nginx::resource::server { $forward_proxy_domain_name :
    ensure      => $forward_proxy_domain_ensure,
    listen_port => $forward_proxy_domain_port,
    proxy       => $forward_proxy_domain_proxy,
    resolver    => $forward_proxy_domain_resolver,
    format_log  => $custom_log_format_name,
  }
}
