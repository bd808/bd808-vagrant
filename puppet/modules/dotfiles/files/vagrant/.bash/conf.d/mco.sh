#!/usr/bin/env bash

builtin hash mco &>/dev/null && {
  [[ -f ~/.mc/client.cfg ]] &&
  export MCOLLECTIVE_EXTRA_OPTS="--config=${HOME}/.mc/client.cfg --dt 1"
}
