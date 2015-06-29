# == Class: phpenv::phpbuild
#
# Install php-build for use with phpenv
#
class phpenv::phpbuild {
    require ::phpenv

    apt::builddep { 'php5': }
    package { [
      'libfcgi-dev',
      'libfcgi0ldbl',
      'libjpeg62-dbg',
      'libmcrypt-dev',
      'libreadline-dev',
      'libssl-dev',
    ]: }

    git::clone { 'phpbuild':
        remote    => 'git://github.com/php-build/php-build.git',
        directory => "${phpenv::dir}/plugins/php-build",
    }
}
