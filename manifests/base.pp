class wewlads::base (
) inherits wewlads::params {

  include wewlads::packages
  include wewlads::privileges

  include wewlads::webserver

  cron { 'puppet apply':
    command => "/opt/puppetlabs/puppet/bin/puppet apply --modulepath ${wewlads::params::apply_module_path} ${wewlads::params::site_pp}",
    user    => 'root',
    minute  => ['0', '30'],
  }

  vcsrepo { "${apply_module_path}/wewlads":
    ensure   => latest,
    provider => git,
    source   => 'https://github.com/demophoon/wewlads-puppet.git',
    revision => 'master',
  }

  file { '/usr/local/bin/dynmotd':
    mode     => '0755',
    content => template('wewlads/motd.erb'),
  }
}
