#!/usr/bin/env bash

# use homebrew installed curl if available
[[ -d "/usr/local/opt/curl" ]] &&
add_root_dir "/usr/local/opt/curl"

builtin hash curl &>/dev/null && {
  alias dpaste="curl -ksF 'content=<-' https://dpaste.de/api/|tr -d '\"';echo"
}
