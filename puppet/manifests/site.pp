Exec {
    logoutput => on_failure,
    timeout   => 900,
    path      => [ '/bin', '/sbin', '/usr/bin', '/usr/local/bin', '/usr/sbin' ],
}

Service {
    ensure => running,
    enable => true,
}

Package {
    ensure => present,
}

File {
    backup => false,
}

hiera_include('classes')
