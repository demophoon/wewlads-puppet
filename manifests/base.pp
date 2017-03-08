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
  
  wewlads::user {'jglenn9k':
    ssh_key => 'AAAAB3NzaC1yc2EAAAABJQAAAgEAgbAfB6DcnLcLtr+DI0Vy0pr96QyM43c7be6PkaD8audnI2udQKTfLUOYQJr1Ny6RuoLUE059hhWPLs8P+5pH6RxeKHVKSgVvNRYgPUTwoxswBI6SbnxLkhSthUrPIwv45aezB6Itnaf3sXFZFLVEcSZ0xerGuKIxNVCGRws5e8oasyXmOXo3vniADw0NY3CTkqZaODp49n8tqehUMuekZ7F/VhXzemp96SSLDzrIpm4eLn4Xfvby9DYGozPV4sAhe62g0NFIwAvv7e8CbzdNL6rdL3lucA4deLQ5TWEANqZu3xKGvWPbttcPh7CBkG/hA3aucHcSiowmCSJauqU9q47KtsHbnev6btYWrIMmb7LmD5LSk5hez/HDFM3m6dri8vc0XI7M1k8R7CuMr/cuXGtYsN4',
    staff => true,
  }
}
