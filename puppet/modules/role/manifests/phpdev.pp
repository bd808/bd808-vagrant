# == Class: role::phpdev
#
# Setup the VM for PHP development.
#
class role::phpdev {
    include ::phpenv

    package { [
        'libyaml-dev',
        'php7.0-cli',
        'valgrind',
    ]: }

#   phpenv::install { '5.5.38': }
#   phpenv::install { '5.5.38-debug':
#       version => '5.5.38',
#       debug   => true,
#   }
#   phpenv::install { '5.5.38-zts':
#       version => '5.5.38',
#       zts     => true,
#   }
#   phpenv::install { '5.5.38-debug-zts':
#       version => '5.5.38',
#       debug   => true,
#       zts     => true,
#   }
#
#   phpenv::install { '5.6.38': }
#   phpenv::install { '5.6.38-debug':
#       version => '5.6.38',
#       debug   => true,
#   }
#   phpenv::install { '5.6.38-zts':
#       version => '5.6.38',
#       zts     => true,
#   }
#   phpenv::install { '5.6.38-debug-zts':
#       version => '5.6.38',
#       zts     => true,
#       debug   => true,
#   }

    phpenv::install { '7.0.32': }
    phpenv::install { '7.1.24': }
    phpenv::install { '7.2.12': }
    phpenv::install { '7.3.17': }
    phpenv::install { '7.4.5': }
}
