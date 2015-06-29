# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.require_version '>= 1.7.0'

Vagrant.configure(2) do |config|
  config.vm.hostname = 'dev'
  config.vm.box = 'ubuntu/trusty64'
  config.vm.network 'private_network', type: 'dhcp'

  if Vagrant.has_plugin?('vagrant-cachier')
        config.cache.scope = :box
  end
  if Vagrant.has_plugin?('vagrant-vbguest')
    config.vbguest.auto_update = true
  end

  config.vm.provider 'virtualbox' do |vb|
    # Give 1/4 of ram to VM
    vb.customize ['modifyvm', :id, '--memory', `sysctl -n hw.memsize`.to_i / 1024 / 1024 / 4]
    # Expose all cores to VM
    vb.customize ['modifyvm', :id, '--cpus', `sysctl -n hw.ncpu`.to_i]
  end

  config.vm.provision :puppet do |puppet|
    puppet.module_path = []
    puppet.manifests_path = [:guest, '/vagrant/puppet/manifests']
    puppet.manifest_file = 'site.pp'
    puppet.options = [
      '--modulepath', '/vagrant/puppet/modules',
      '--hiera_config', '/vagrant/puppet/hiera/hiera.yaml',
      '--verbose',
      '--logdest', 'console',
      '--detailed-exitcodes',
    ]
    puppet.options << '--debug' if ENV.include?('PUPPET_DEBUG')
  end

end
