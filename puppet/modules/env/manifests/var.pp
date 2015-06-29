define env::var(
    $value,
    $ensure = 'present',
) {
    env::profile { $title:
        ensure  => $ensure,
        content => template('env/set_var.erb'),
    }
}
