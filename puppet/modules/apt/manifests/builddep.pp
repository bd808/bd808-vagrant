define apt::builddep {
    exec { "apt-builddep-${name}":
        command   => "/usr/bin/apt-get -y --force-yes build-dep ${name}",
        logoutput => 'on_failure',
    }
}
