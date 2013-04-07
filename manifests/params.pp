# Class: sickbeard::params
#
# This class defines default parameters used by the main module class sickbeard
# Operating Systems differences in names and paths are addressed here
#
# == Variables
#
# Refer to sickbeard class for the variables defined here.
#
# == Usage
#
# This class is not intended to be used directly.
# It may be imported or inherited by other classes
#
class sickbeard::params {

	### Application related parameters

	$path = $::operatingsystem ? {
		default => '/usr/share/sickbeard'
	}

    $user     = 'sickbeard'
    $data_dir = '/var/lib/sickbeard'

	$enabled = true

}
