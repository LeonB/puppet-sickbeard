class sickbeard(
  $path     = params_lookup( 'path' ),
  $user     = params_lookup( 'user' ),
  $data_dir = params_lookup( 'data_dir' ),
  $enabled  = params_lookup( 'enabled' )
  ) inherits sickbeard::params {

  # install php before sickbeard
  Class['python'] -> Class['sickbeard']

    $ensure = $enabled ? {
      true => present,
      false => absent
    }

  include sickbeard::package, sickbeard::config, sickbeard::service
}
