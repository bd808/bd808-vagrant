# == Class: role::phpdev
#
# Setup the VM for PHP development.
#
class role::phpdev {
    include ::phpenv

    package { [
        'libyaml-dev',
        'php5-cli',
        'valgrind',
    ]: }

    phpenv::install { '5.5.38': }
    phpenv::install { '5.5.38-debug':
        version => '5.5.38',
        debug   => true,
    }
    phpenv::install { '5.5.38-zts':
        version => '5.5.38',
        zts     => true,
    }
    phpenv::install { '5.5.38-debug-zts':
        version => '5.5.38',
        debug   => true,
        zts     => true,
    }

    phpenv::install { '5.6.31': }
    phpenv::install { '5.6.31-debug':
        version => '5.6.31',
        debug   => true,
    }
    phpenv::install { '5.6.31-zts':
        version => '5.6.31',
        zts     => true,
    }
    phpenv::install { '5.6.31-debug-zts':
        version => '5.6.31',
        zts     => true,
        debug   => true,
    }

    phpenv::install { '7.0.21': }
    phpenv::install { '7.1.7': }
}
