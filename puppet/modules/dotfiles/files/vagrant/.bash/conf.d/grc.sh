#!/usr/bin/env bash
# grc & grcat: general purpose colorizer

builtin hash grc &>/dev/null && [[ $TERM != dumb ]] && {
  export GRC_COLOR=auto
  alias grc='grc -es --colour=${GRC_COLOR}'
  #alias configure='colourify ./configure'
  for p in diff make gmake gcc g++ as gas ld netstat ping traceroute svn; do
    builtin hash $p &>/dev/null && alias ${p}="grc ${p}"
  done
}
