# Class to configure custom_nginx reverse proxy
class custom_nginx::reverse_proxy inherits custom_nginx {
  # Setup main location for domain.com reverse proxy connections
  nginx::resource::server { $reverse_proxy_domain_name :
    ensure      => $reverse_proxy_ensure,
    ssl         => $reverse_proxy_ssl,
    ssl_cert    => $ssl_cert,
    ssl_key     => $ssl_key,
    listen_port => $reverse_proxy_port,
    proxy       => $reverse_proxy_domain_proxy,
  }

  # Setup secondary location for domain.com/resource for reverse proxy connections
  nginx::resource::location { $reverse_proxy_resource_name :
    ensure          => $reverse_proxy_resource_ensure,
    ssl             => $reverse_proxy_resource_ssl,
    ssl_only        => $reverse_proxy_resource_ssl_only,
    server          => $reverse_proxy_domain_name,
    location        => $reverse_proxy_resource_location,
    proxy           => $reverse_proxy_resource_proxy,
  }

  # Setup health check for domain.com 
  nginx::resource::upstream { 'backend_root':
    members => {
      '10.10.10.10:443' => {
        server       => '10.10.10.10',
        port         => 443,
        weight       => 5,
	max_fails    => 2,
	fail_timeout => '30s',
      },
      '10.10.10.11:443' => {
        server       => '10.10.10.11',
        port         => 443,
        weight       => 1,
	max_fails    => 2,
	fail_timeout => '30s',
      },
    },
  }

  # Setup health check for domain.com/resource 
  nginx::resource::upstream { 'backend_resource':
    members => {
      '20.20.20.20:443' => {
        server       => '20.20.20.20',
        port         => 443,
        weight       => 5,
        max_fails    => 2,
        fail_timeout => '30s',
      },
      '20.20.20.21:443' => {
        server       => '20.20.20.21',
        port         => 443,
        weight       => 1,
        max_fails    => 2,
        fail_timeout => '30s',
      },
    },
  }
}
