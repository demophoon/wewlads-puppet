class wewlads::packages {
  $install_packages = concat([
    'vim',
    'emacs',
    'irssi',
    'bash',
    'ntp',
    'zsh',
  ], $wewlads::params::base_install_packages)

  package { $install_packages:
    ensure => present,
  }
}
