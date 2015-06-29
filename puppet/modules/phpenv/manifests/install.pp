# == Define: phpenv::install
#
# Install a PHP interpreter for use with phpenv
#
# == Parameters:
# [*version*]
#   PHP version to install. Default $title.
#
# [*pear*]
#   Install PEAR in addition to Pyrus? Default false.
#
# [*xdebug*]
#   Enable XDebug. Default true.
#
# [*zts*]
#   Enable Zend Thread Safety. Default false.
#
# [*config_opts*]
#   Additional configuration options. Default ''.
#
# [*extensions*]
#   Additional extensions to install. Each array entry should be an
#   EXTENSION=VERSION definition. Default [].
#
define phpenv::install(
    $version     = $title,
    $envionment  = 'production',
    $pear        = false,
    $xdebug      = true,
    $zts         = false,
    $debug       = false,
    $config_opts = '',
    $extensions  = [],
) {
    require ::phpenv
    require ::phpenv::phpbuild

    $dir = "${::phpenv::dir}/versions/${title}"

    $pearOpt = $pear ? {
        true    => '--pear',
        default => '',
    }
    $envXDebug = $xdebug ? {
        true    => 'on',
        default => 'off',
    }
    $envZTS = $zts ? {
        true    => 'on',
        default => 'off',
    }
    $envCflags = $debug ? {
        true    => '-g3',
        default => '',
    }
    $envExt = inline_template('<%= @extensions.join(" ") %>')
    $envConfig = $debug ? {
        true    => "--enable-debug ${config_opts}",
        default => $config_opts,
    }

    exec { "compile php-${title}":
        command     => "${phpenv::dir}/plugins/php-build/bin/php-build --ini ${environment} ${pearOpt} ${version} ${dir}",
        environment => [
            'HOME=/home/vagrant',
            'LDFLAGS=-lstdc++',
            "CFLAGS=${envCflags}",
            "PHP_VERSION=${version}",
            "PHP_BUILD_ZTS_ENABLE=${envZTS}",
            "PHP_BUILD_XDEBUG_ENABLE=${envXDebug}",
            "PHPBUILD_INSTALL_EXTENSION=${envExt}",
            "PHP_BUILD_CONFIGURE_OPTS=${envConfig}",
        ],
        creates     => "${dir}/bin/php",
    }
}
