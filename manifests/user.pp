define wewlads::user (
  Enum[present, absent] $ensure = present,
  String $username = $title,
  String $ssh_key_type = 'ssh-rsa',
  String $ssh_key,
  String $shell = '/bin/bash',
  Boolean $staff = false,

  # changeMe1
	String $default_password = '$1$9mPccA/o$xW.6fljBE2nU9rkE7vfKc/',
) {

  if $staff {
    $groups = ['lad', 'staff']
  } else {
		$groups = ['lad']
  }

  user { $username:
    ensure         => $ensure,
    groups				 => $groups,
    managehome     => true,
    home           => "/home/${username}",
    purge_ssh_keys => true,
    shell          => $shell,
  }

	if $ensure == present {
    $ssh_dir_ensure = directory
  } else {
    $ssh_dir_ensure = absent
  }
  file { "/home/${username}/.ssh":
    ensure  => $ssh_dir_ensure,
    owner   => $username,
    group   => 'lad',
    mode    => '0700',
    require => User[$username],
  }

  ssh_authorized_key { $username:
    ensure  => $ensure,
    user    => $username,
    type    => $ssh_key_type,
    key     => $ssh_key,
    require => File["/home/${username}/.ssh"],
  }

  exec { "/usr/sbin/usermod -p '${default_password}' ${username}":
      onlyif => "/bin/egrep '^${username}:!!:.*:' /etc/shadow",
      require => User[$username];
  }

}

