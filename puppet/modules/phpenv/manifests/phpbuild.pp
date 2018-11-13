# == Class: phpenv::phpbuild
#
# Install php-build for use with phpenv
#
class phpenv::phpbuild {
    require ::phpenv

    apt::builddep { 'php7.0': }
    package { [
      'libcurl4-openssl-dev',
      'libfcgi-dev',
      'libfcgi0ldbl',
      'libjpeg-dev',
      'libmcrypt-dev',
      'libreadline-dev',
      'libssl-dev',
      'libzip-dev',
    ]: }

    git::clone { 'phpbuild':
        ensure    => 'latest',
        remote    => 'git://github.com/php-build/php-build.git',
        directory => "${phpenv::dir}/plugins/php-build",
    }

    # Workaround for building PHP5 with newer curl header layout
    # https://github.com/phpbrew/phpbrew/issues/925#issuecomment-310196141
    file { '/usr/local/include/curl':
        ensure  => 'link',
        target  => '/usr/include/x86_64-linux-gnu/curl',
        require => Package['libcurl4-openssl-dev'],
    }
}
