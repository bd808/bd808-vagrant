class apt {
    exec { 'update_package_index':
        command  => 'apt-get update',
        schedule => 'daily',
    }

    file { '/etc/apt/apt.conf.d/01no-recommended':
        source => 'puppet:///modules/apt/01no-recommended',
        owner  => 'root',
        group  => 'root',
        mode   => '0444',
    }

    Class['Apt'] -> Package <| |>
}
