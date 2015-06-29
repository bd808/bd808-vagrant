# nodejs config

[[ -d /usr/local/lib/node_modules ]] &&
export NODE_PATH=.:/usr/local/lib/node_modules

[[ -d /usr/local/share/npm/bin ]] &&
list_add_dir PATH "/usr/local/share/npm/bin"
