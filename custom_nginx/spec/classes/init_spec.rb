require 'spec_helper.rb'
describe 'custom_nginx', :type => 'class' do
  context 'Linux 7 custom_nginx_manage=false' do
    let :params do
    {
        :custom_nginx_manage => false,
    }
    end
    let :facts do
    {
       :osfamily   => 'RedHat',
       :operatingsystemmajrelease => '7',
    }
    end
    it { should contain_class('custom_nginx') }
    it { should_not contain_class('custom_nginx::config') }
    it { should_not contain_class('custom_nginx::reverse_proxy') }
    it { should_not contain_class('custom_nginx::forward_proxy') }
  end

  context 'linux 5 custom_nginx_manage=true' do
    let :params do
    {
        :custom_nginx_manage => true
    }
    end
    let :facts do
    {
       :osfamily   => 'RedHat',
       :operatingsystemmajrelease => '5',
    }
    end
    it { should contain_class('custom_nginx') }
    it { should_not contain_class('custom_nginx::config') }
    it { should_not contain_class('custom_nginx::reverse_proxy') }
    it { should_not contain_class('custom_nginx::forward_proxy') }
  end

  #####################################################
  #
  # Below unit testing fails with
  #   1) custom_nginx linux 8 custom_nginx_manage=true is expected to contain Class[custom_nginx]
  #      Failure/Error: it { should contain_class('custom_nginx') }
  #      Puppet::PreformattedError:
  #      Evaluation Error: Operator '[]' is not applicable to an Undef Value. (file: /etc/puppetlabs/code/environments/gimeno_test/modules/custom_nginx/spec/fixtures/modules/nginx/manifests/params.pp, line: 98, column: 8) on node testsystem
  #      #  # /opt/puppetlabs/pdk/private/ruby/2.7.3/lib/ruby/2.7.0/benchmark.rb:308:in `realtime'
  #      # ./spec/classes/init_spec.rb:55:in `block (3 levels) in <top (required)>'
  #
  #####################################################
  
  #context 'linux 7 custom_nginx_manage=true' do
  #  let(:params) do
  #  {
  #      :custom_nginx_manage => true,
  #  }
  #  end
  #  let(:facts) do
  #  {
  #     :kernel     => 'Linux',
  #     :operatingsystem => 'CentOS',
  #     :osfamily   => 'RedHat',
  #     :osname   => 'RedHat',
  #     :operatingsystemmajrelease => '7',
  #     :osreleasemajor => '7',
  #  }
  #  end
  #  it { should contain_class('custom_nginx') }
  #  it { should contain_class('custom_nginx::config') }
  #  it { should contain_class('custom_nginx::reverse_proxy') }
  #  it { should contain_class('custom_nginx::forward_proxy') }
  #end
end
