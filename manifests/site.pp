Exec {
  logoutput => 'on_failure',
  path      => '/usr/bin:/usr/sbin:/bin:/sbin',
}

#case $::osfamily {
#  'Debian': {
#    Package { subscribe => Exec['apt_update'] }
#  }
#}

node pemaster {
  class { '::hiera':
    hierarchy => [
      'nodes/%{hostname}',
      'common'
    ],
    datadir   => '/vagrant/environments/%{environment}/data',
  }

  class { '::r10k':
    sources   => {
      'conf2014demosite' => {
        'remote'         => 'git://github.com/xaque208/conf2014demosite.git',
        'basedir'        => '/vagrant/environments',
      },
    },
    purgedirs => [
      '/vagrant/environments',
    ]
  }
}

node default {
  hiera_include('classes')

  @@host { $::fqdn:
    ip => $::ipaddress_eth1
  }

  Host <<||>>
}
