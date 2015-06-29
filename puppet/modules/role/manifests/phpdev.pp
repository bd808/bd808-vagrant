# == Class: role::phpdev
#
# Setup the VM for PHP development.
#
class role::phpdev {
    include ::phpenv

    package { [
        'libyaml-dev',
        'php5-cli',
    ]: }

    Phpenv::Install {
        debug => true,
    }

    phpenv::install { '5.5.26': }
    phpenv::install { '5.5.26-ZTS':
        version => '5.5.26',
        zts     => true,
    }

    phpenv::install { '5.6.7': }
    phpenv::install { '5.6.7-ZTS':
        version => '5.6.7',
        zts     => true,
    }

    phpenv::install { '7.0.0':
        version => '7.0.0alpha2',
    }
    phpenv::install { '7.0.0-ZTS':
        version => '7.0.0alpha2',
        zts     => true,
    }
    # TODO: aliases with symlinks like travis does
}
