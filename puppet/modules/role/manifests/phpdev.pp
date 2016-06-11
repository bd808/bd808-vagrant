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

    #phpenv::install { '5.3.3': }
    #phpenv::install { '5.3.3-debug':
    #    version => '5.3.3',
    #    debug   => true,
    #}
    #phpenv::install { '5.3.3-zts':
    #    version => '5.3.3',
    #    zts     => true,
    #}
    #phpenv::install { '5.3.3-debug-zts':
    #    version => '5.3.3',
    #    debug   => true,
    #    zts     => true,
    #}

    phpenv::install { '5.5.26': }
    phpenv::install { '5.5.26-debug':
        version => '5.5.26',
        debug   => true,
    }
    phpenv::install { '5.5.26-zts':
        version => '5.5.26',
        zts     => true,
    }
    phpenv::install { '5.5.26-debug-zts':
        version => '5.5.26',
        debug   => true,
        zts     => true,
    }

    phpenv::install { '5.6.7': }
    phpenv::install { '5.6.7-debug':
        version => '5.6.7',
        debug   => true,
    }
    phpenv::install { '5.6.7-zts':
        version => '5.6.7',
        zts     => true,
    }
    phpenv::install { '5.6.7-debug-zts':
        version => '5.6.7',
        zts     => true,
        debug   => true,
    }

    phpenv::install { '7.0.7': }
    #phpenv::install { '7.0.7-debug':
    #    version => '7.0.7',
    #    debug   => true,
    #}
    #phpenv::install { '7.0.7-zts':
    #    version => '7.0.7',
    #    zts     => true,
    #}
    #phpenv::install { '7.0.7-debug-zts':
    #    version => '7.0.7',
    #    zts     => true,
    #    debug   => true,
    #}
    # TODO: aliases with symlinks like travis does
}
