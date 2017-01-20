class wewlads::base (
) inherits wewlads::params {

  include wewlads::packages
  include wewlads::privileges

  include wewlads::webserver

  wewlads::user { 'demophoon':
    ssh_key      => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQCoGprqMrYegwmvsbyENxYThKBOO5Ep8FUnD99Ms244njxdoGp3AbvQZSytL0wkzhcNoQoGe++Z1AWet0NpudwujF0EphZoffWt+0dRBlxeGBfdRydQMngBA6V95NBvugBUyxH9p9ehC/tz6+tKP4iCfPhJAyuBjDKfSiIuZoSRraH+83nlK/Tqgh3KrLlYVRblCl9XxWLIq3UCpoeSl9jQPRXda9u2BUsVu821GfdSFiC2tKpQYSXOJcVZpPI/Zuv2B589FER0ceEuwbOHy/8LHrJEE67tW6W6mb7vBKIp7eTq61ts3jNRMHB3LVBgnS3YzkAA9BlecPvqQlTsHyRH',
    staff        => true,
  }

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
