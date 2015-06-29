#!/usr/bin/env bash
# startup a gnome-keyring session if available

# FIXME: this is not working correctly anymore.
# Repeated logins create multiple daemons that are not cleaned up at exit.
# Seems to also cause wonkyness with tmux.
#builtin hash dbus-launch &>/dev/null && {
#  eval $(dbus-launch --sh-syntax)
#  # don't enable ssh add-on, it clobbers agent forwarding
#  export $(gnome-keyring-daemon -c pkcs11,secrets)
#}
