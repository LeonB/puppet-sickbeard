class sickbeard::package {

    git::repo { 'sickbeard':
        path   => $sickbeard::path,
        source => 'git://github.com/midgetspy/Sick-Beard.git',
        owner  => $sickbeard::user,
        group  => $sickbeard::user,
        mode   => 0644,
    }

}
