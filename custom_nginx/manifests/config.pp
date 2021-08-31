# Class to configure custom_nginx main conf
class custom_nginx::config inherits custom_nginx {
  class { '::nginx':
    service_manage => $service_manage,
    service_ensure => $service_ensure,
    service_enable => $service_enable,     
    log_format     => {
                        $custom_log_format_name => $custom_log_format
                      },
  }
}
