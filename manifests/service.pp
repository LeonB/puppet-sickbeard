class sickbeard::service {

  service { 'sickbeard':
    ensure     => running,
    hasstatus  => true,
    hasrestart => true,
    enable     => true,
    require    => Class['sickbeard::package'],
  }
}
