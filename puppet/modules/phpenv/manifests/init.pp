# == Class: phpenv
#
# Install phpenv tool for managing multiple PHP versions
#
class phpenv(
    $dir     = '/srv/phpenv',
    $src_dir = '/srv/phpenv.git',
) {
    git::clone { 'phpenv':
        remote    => 'git://github.com/CHH/phpenv.git',
        directory => $src_dir,
    }

    exec { 'install_phpenv':
        command     => "${src_dir}/bin/phpenv-install.sh",
        environment => "PHPENV_ROOT=${dir}",
        creates     => $dir,
        require     => Git::Clone['phpenv']
    }

    file { "${dir}/plugins":
        ensure  => 'directory',
        require => Exec['install_phpenv'],
    }

    file { "${dir}/shims":
        ensure  => 'directory',
        require => Exec['install_phpenv'],
    }

    env::profile { 'phpenv':
        content => template('phpenv/env.sh.erb'),
    }

    exec { 'rehash phpenv':
        command     => "${dir}/bin/phpenv init - && ${dir}/bin/phpenv rehash",
        refreshonly => true,
        require => [
            Exec['install_phpenv'],
            File["${dir}/plugins"],
            File["${dir}/shims"],
        ],
    }
}
