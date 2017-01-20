class wewlads::privileges {

  group { 'staff':
    ensure => present,
  }

  group { 'lad':
    ensure => present,
  }

  class { 'sudo': }

  sudo::conf {'staff':
    ensure  => present,
    content => '%staff ALL=(ALL) ALL',
    priority => 10,
  }

  # Set super user permissions
  sudo::conf {'root':
    ensure  => present,
    content => 'root ALL=(ALL) NOPASSWD: ALL',
    priority => 5,
  }
  sudo::conf {'ec2-user':
    ensure  => present,
    content => 'ec2-user ALL=(ALL) NOPASSWD: ALL',
    priority => 6,
  }

}
