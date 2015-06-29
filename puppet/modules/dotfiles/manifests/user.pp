# == Define: dotfiles::user
#
define dotfiles::user {
    file { "/home/${name}":
        ensure       => 'directory',
        source       => [
            "puppet:///modules/dotfiles/${name}/",
            'puppet:///modules/dotfiles/_skel',
        ],
        sourceselect => 'first',
        recurse      => 'remote',
        mode         => '0644',
        owner        => $name,
        force        => true,
    }
}
