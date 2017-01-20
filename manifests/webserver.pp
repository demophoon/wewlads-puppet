class wewlads::webserver {

  include nginx

  nginx::resource::server { 'wewlads.club':
    www_root => '/var/www/wewladsclub/',
  }
  nginx::resource::server { 'www.wewlads.club':
    www_root => '/var/www/wewladsclub/',
  }
}
