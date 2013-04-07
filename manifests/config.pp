class sickbeard::config {

    # do package before config
    Users::Account["${sickbeard::user}"] -> Class['sickbeard::package']

    users::account { $sickbeard::user:
        ensure  => $sickbeard::ensure,
        uid     => 130,
        # groups  => ['sabnzbdplus'],
        home    => $sickbeard::path,
        shell   => '/bin/false',
        comment => 'Sickbeard',
    }

    nginx::vhost::snippet { 'sickbeard':
        vhost   => 'default',
        content => template('sickbeard/nginx_vhost.erb'),
        ensure  => $sickbeard::ensure
     }

    file { '/etc/default/sickbeard':
        owner   => 'root',
        group   => 'root',
        mode    => 0644,
        content => template('sickbeard/default/sickbeard.erb'),
    }

    # file { '/etc/init.d/sickbeard':
    #     ensure => 'link',
    #     target => "${sickbeard::path}/init.ubuntu",
    #     require => Class['sickbeard::package'],
    # }

    file { "${sickbeard::path}/init.ubuntu":
        owner   => 'root',
        group   => 'root',
        mode    => 0700, #rwx
        source  => 'puppet:///modules/sickbeard/init.ubuntu',
        require => Class['sickbeard::package'],
    }

    file {
        [
            "${sickbeard::data_dir}",
            '/etc/sickbeard/',
        ]:
            ensure  => $sickbeard::ensure ? { present => directory, default => $ensure },
            owner   => $sickbeard::user,
            group   => $sickbeard::user,
            mode    => 0640, # rw,r
    }

    file { '/etc/sickbeard/config.ini':
        ensure  => $sickbeard::ensure,
        content => template("sickbeard/config.ini.erb"),
        owner   => $sickbeard::user,
        group   => $sickbeard::user,
        mode    => 0640, # rw,r
        require => Class['sickbeard::package'],
        notify  => Class['sickbeard::service'],
    }

    file { "${sickbeard::data_dir}/config.ini":
        ensure  => $sickbeard::ensure ? { present => link, default => $ensure },
        target  => '/etc/sickbeard/config.ini',
        require => Class['sickbeard::package'],
    }

}
