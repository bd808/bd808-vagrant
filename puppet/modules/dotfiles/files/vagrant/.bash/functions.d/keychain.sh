# Start a keychain session if keychain is available
start_keychain () {
  if hash keychain &>/dev/null ; then
    # start keychain and load default ssh and gpg keys
    # TODO: this should be configurable
    keychain ~/.ssh/id_rsa 69832B13
    local h=$(uname -n)
    source ~/.keychain/${h}-sh

    # hookup gpg agent if available too
    [ -f "$HOME/.keychain/${h}-sh-gpg" ] && {
      source "$HOME/.keychain/${h}-sh-gpg"
    }

  else
    echo "Unable to start keychain. Program not found."
  fi
}

# vim:sw=2 ts=2 sts=2 et ft=sh:

