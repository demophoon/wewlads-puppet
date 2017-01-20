class wewlads::packages {
  $install_packages = [
    'vim',
    'emacs',
    'irssi',
    'bash',
    'ntp',
    'zsh',
  ]

  package { $install_packages:
    ensure => present,
  }
}
