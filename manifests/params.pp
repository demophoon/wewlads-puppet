class wewlads::params {
  $apply_module_path = '/root/modules'
  $site_pp = "${apply_module_path}/wewlads/site.pp"

  case $::operatingsystem {
    'redhat': {
      $base_install_packages = ['epel-release']
    }
    default: {
      $base_install_packages = []
    }
  }
}
